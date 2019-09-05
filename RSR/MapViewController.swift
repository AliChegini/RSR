//
//  MapViewController.swift
//  RSR
//
//  Created by Ehsan on 03/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit
import MapKit
import Network


class MapViewController: UIViewController {
    
    // UI elements all in code
    
    let mapView: MKMapView = {
       let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.showsUserLocation = true
        return map
    }()
    
    
    let callButton: UIButton = {
        let button = UIButton()
        let iconImage = UIImage(named: "ic_call")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Bel RSR nu", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.setBackgroundImage(UIImage(named: "btn_normal"), for: .normal)
        button.setImage(iconImage, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 150)
        button.addTarget(self, action: #selector(callRSR), for: .touchUpInside)
        
        return button
    }()
    
    
    private let permissionManager = PermissionManager()
    private let locationManager = LocationManager()
    
    let networkMonitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkMonitor")
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupViews()
        
        permissionManager.permissionDelegate = self
        locationManager.locationDelegate = self
        
        // check for internet connection
        networkMonitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                
                // alert the user to check internet connection
                let alert = UIAlertController(title: "Internet Error", message: "Unable to locate your address. Please check your internet connection.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                    // TODO: after retry should update status but its not updated
                    print("Status after retry: \(path.status)")
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                print(path.status)
            }
        }
        
        
        networkMonitor.start(queue: queue)
        
        
        // request permission
        do {
            try permissionManager.requestPermission()
            
        } catch {
            
            // alert the user in case of denied permission
            let alert = UIAlertController(title: "Location Permission", message: "Please authorize RSR to find your location while using the app.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    // open the app permission in Settings app
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        
        locationManager.requestLocation()
        
    
    }
    
    
    @objc func callRSR() {
        let number = "00319007788990"
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    
    
    
    
    // LocationManagerDelegate methods
    
    func obtainedLocation(_ address: String, _ coordinate: CLLocationCoordinate2D) {
        // mapView preparation
        // TODO: need refactoring
//        let annotation = MKPointAnnotation()
//        annotation.title = address
//        annotation.coordinate = coordinate
//        mapView.addAnnotation(annotation)
        
    }
    
    func failedToObtainLocation(_ error: Error) {
        print("Failed to obtain location: \(error.localizedDescription)")
    }
    
    
    // PermissionManagerDelegate methods
    
    func authorizationSucceeded() {
        print("permission is granted")
    }
    
    func authorizationFailedWithStatus(_ status: CLAuthorizationStatus) {
        print("permission is not granted --- status \(status)")
    }
    
    
    
}




extension MapViewController: LocationManagerDelegate, PermissionManagerDelegate {
    
    func setupNavigationBar() {
        navigationItem.title = "RSR Pechhulp"
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "terug_normal")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "terug_normal")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    func setupViews() {
        view.addSubview(mapView)
        view.addSubview(callButton)
        
        // auto layout constraint for map view
        mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        
        // auto layout constraint for assistance button
        callButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        callButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        callButton.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        callButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        callButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }
}
