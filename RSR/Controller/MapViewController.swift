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


class MapViewController: UIViewController, MKMapViewDelegate {
    
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
    
    
    let callChargeView: UIView = {
       let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.backgroundColor = .green
        customView.isHidden = true
        
        let titleLabel = UILabel()
        titleLabel.text = "Hello world"
        let messageLabel = UILabel()
        messageLabel.text = "It's me"
        let ringButton = UIButton()
        ringButton.setTitle("Bel nu", for: .normal)
        let cancelButton = UIButton()
        cancelButton.setTitle("Annuleren", for: .normal)
        
        customView.addSubview(titleLabel)
        customView.addSubview(messageLabel)
        customView.addSubview(ringButton)
        customView.addSubview(cancelButton)
        
        customView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        customView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        return customView
    }()
    
    
    
    
    private let permissionManager = PermissionManager()
    private let locationManager = LocationManager()
    
    let networkMonitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkMonitor")

    // by default isLocationObtained is false
    var isUserLocationObtained: Bool = false {
        didSet {
            print("we can easily observe the isUserLocationObtained \(self.isUserLocationObtained)")
        }
    }
    
    // by default network status is unknown
    var networkStatus: NetworkStatus = .unknown
    
    
    var pin: CustomAnnotation!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupViews()
        
        mapView.delegate = self
        
        permissionManager.permissionDelegate = self
        locationManager.locationDelegate = self
        
        
        
        // check for internet connection
        networkMonitor.pathUpdateHandler = { path in
            
            print("This is the path status \(path.status)")
            // Note: NWPath won't change within a given invocation of pathUpdateHandler
            // unless the view gets dismissed
            if path.status == .satisfied {
                self.networkStatus = .connected
            } else {
                self.networkStatus = .notConnected
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
        
        
        // if device is notConnected show network alert
        if networkStatus == .notConnected{
            showNetworkAlert()
        } else if (isUserLocationObtained == false) || (networkStatus == .connected) {
            locationManager.requestLocation()
        }
        
    
    }
    
    func showNetworkAlert() {
        // alert the user to check internet connection
        let alert = UIAlertController(title: "Internet Error", message: "Unable to locate your address. Please check your internet connection.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (action) in
            // if user location is still not obtained request it and show alert
            if self.isUserLocationObtained == false {
                self.locationManager.requestLocation()
                self.showNetworkAlert()
            }
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @objc func callRSR() {
        callChargeView.isHidden = false
        view.addSubview(callChargeView)
        hideElements()
//        let number = "00319007788990"
//        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url)
//        }
    }
    
    
    
    
    
    // LocationManagerDelegate methods
    
    func obtainedLocation(_ address: String, _ coordinate: CLLocationCoordinate2D) {
        // mapView preparation
        // TODO: need refactoring
        pin = CustomAnnotation(coordinate: coordinate, title: address)
        mapView.addAnnotation(pin)
        mapView.selectAnnotation(pin, animated: true)
        isUserLocationObtained = true
    }
    
    func failedToObtainLocation(_ error: Error) {
        isUserLocationObtained = false
        print("Failed to obtain location: \(error.localizedDescription)")
    }
    
    
    // PermissionManagerDelegate methods
    
    func authorizationSucceeded() {
        print("permission is granted")
    }
    
    func authorizationFailedWithStatus(_ status: CLAuthorizationStatus) {
        print("permission is not granted --- status \(status)")
    }
    
    
    // methods for Custom annotations
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKAnnotationView(annotation: pin, reuseIdentifier: "UserLocation")
        annotationView.image = UIImage(named: "marker")
        annotationView.canShowCallout = true
        configureDetailView(annotationView: annotationView)

        return annotationView
        
    }
    
    
    func configureDetailView(annotationView: MKAnnotationView) {
        let width = 300
        let height = 200
        
        let calloutView = UIView()
        calloutView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["calloutView": calloutView]
        
        calloutView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[calloutView(300)]", options: [], metrics: nil, views: views))
        calloutView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[calloutView(200)]", options: [], metrics: nil, views: views))
       
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageView.image = UIImage(named: "address_back")
        
        calloutView.addSubview(imageView)
        
        annotationView.detailCalloutAccessoryView = calloutView
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
    
    func hideElements() {
        callButton.isHidden = true
    }
    
    
}
