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
    
    let mapView: MKMapView = {
       let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.showsUserLocation = true
        
        return map
    }()
    
    
    
    private let popupBoxView = PopupBoxView().popupBox
    private let callButton = CallButtonView().callButton
    
    // calloutView consist of two parts,
    // static parts(top and bottom label) and dynamic part(address)
    private let callout = CalloutViews()
    
    private let permissionManager = PermissionManager()
    private let locationManager = LocationManager()
    
    // constants for monitoring network status
    let networkMonitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkMonitor")

    // by default isLocationObtained is false
    var isUserLocationObtained: Bool = false
    
    // by default network status is unknown
    var networkStatus: NetworkStatus = .unknown
    
    var pin: CustomAnnotation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupViews()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
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
        popupBoxView.isHidden = false
        hideElements()
    }
    
    
    @objc func cancelAction() {
        print("cancel button is tapped")
        popupBoxView.isHidden = true
        showElements()
    }
    
    
    @objc func confirmedCallRSR() {
        let number = "00319007788990"
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    
    
    // LocationManagerDelegate methods
    
    func obtainedLocation(_ address: String, _ coordinate: CLLocationCoordinate2D) {
        // mapView preparation
        // TODO: need refactoring
        pin = CustomAnnotation(coordinate: coordinate, title: address)
        mapView.addAnnotation(pin)
        isUserLocationObtained = true
        callout.configureAddressLabel(address: address)
        
        // Zooming on annotation
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        mapView.selectAnnotation(pin, animated: true)
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
        annotationView.canShowCallout = false
        
        return annotationView
    }
    
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        view.addSubview(callout.calloutWithoutAddress)
        
        // constraints for calloutView
        // view is the pin(marker)
        NSLayoutConstraint.activate([
            callout.calloutWithoutAddress.bottomAnchor.constraint(equalTo: view.topAnchor),
            callout.calloutWithoutAddress.widthAnchor.constraint(equalToConstant: 250),
            callout.calloutWithoutAddress.heightAnchor.constraint(equalToConstant: 250),
            callout.calloutWithoutAddress.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -10)
            ])
        
        
        
        
    }
    

}



// extension

extension MapViewController: LocationManagerDelegate, PermissionManagerDelegate {
    
    func setupNavigationBar() {
        navigationItem.title = "RSR Pechhulp"
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "terug_normal")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "terug_normal")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    func setupViews() {
        view.addSubview(mapView)
        view.addSubview(callButton)
        view.addSubview(popupBoxView)
        
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
        
        
        // autolayout constraint for popupBox
        popupBoxView.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        popupBoxView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        popupBoxView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popupBoxView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    func hideElements() {
        callout.calloutWithoutAddress.isHidden = true
        callButton.isHidden = true
    }
    
    func showElements() {
        callout.calloutWithoutAddress.isHidden = false
        callButton.isHidden = false
    }
    
    
}
