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
    
    // UI elements and a function to setup the autolayout constraints are included in mapViewElements
    let mapViewElements = MapViews()
    
    // UI elements and a function to setup the autolayout constraints are included in calloutElements
    let calloutElements = CalloutViews()
    
    // All the UI elements for iPhone popup, and a function to
    // setup the autolayout constraints are included in popupElements
    let popupElements = IPhonePopupViews()
    

    // All the UI elements for iPad footer, and a function to
    // setup the autolayout constraints are included in footerElements
    let footerElements = IPadFooterViews()
    
    
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
        mapViewElements.setupViews(view: view)
        
        // check device type and show related popup/footerView
        if UIDevice.current.userInterfaceIdiom == .phone {
            popupElements.setupViews(view: view)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            mapViewElements.callButton.isHidden = true
            footerElements.setupViews(view: view)
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        permissionManager.permissionDelegate = self
        locationManager.locationDelegate = self
        mapViewElements.mapView.delegate = self
        
        // check for internet connection
        networkMonitor.pathUpdateHandler = { path in
            // Note: NWPath won't change within a given invocation of pathUpdateHandler
            // unless the view gets dismissed
            if path.status == .satisfied {
                self.networkStatus = .connected
            } else {
                self.networkStatus = .notConnected
            }
        }
        
        networkMonitor.start(queue: queue)
        
        
        do {  // request permission
            try permissionManager.requestPermission()
        } catch {
            showPermissionAlert()
        }
        
        
        // if device is notConnected show network alert
        if networkStatus == .notConnected{
            showNetworkAlert()
        } else if (isUserLocationObtained == false) || (networkStatus == .connected) {
            locationManager.requestLocation()
        }
        
    }
    
    
    
    @objc func callRSR() {
        UIView.transition(with: popupElements.popupBox, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.popupElements.popupBox.isHidden = false
        })
        
        hideElements()
    }
    
    
    @objc func cancelAction() {
        UIView.transition(with: popupElements.popupBox, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.popupElements.popupBox.isHidden = true
        })
        
        showElements()
    }
    
    
    @objc func confirmedCallRSR() {
        let number = "00319007788990"
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    
    @objc func callRSRIpad() {
        let number = "00319007788990"
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    
    // methods for Custom annotations
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKAnnotationView(annotation: pin, reuseIdentifier: "UserLocation")
        annotationView.image = UIImage(named: "marker")
        annotationView.canShowCallout = false
        
        return annotationView
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        calloutElements.setupViews(view: view)
    }
    
}



// MapViewController Extension

extension MapViewController: LocationManagerDelegate, PermissionManagerDelegate {
    
    // PermissionManagerDelegate methods
    
    func authorizationSucceeded() {
        print("permission is granted")
    }
    
    func authorizationFailedWithStatus(_ status: CLAuthorizationStatus) {
        print("permission is not granted --- status \(status)")
    }
    
    
    // LocationManagerDelegate methods
    
    func obtainedLocation(_ address: String, _ coordinate: CLLocationCoordinate2D) {
        
        pin = CustomAnnotation(coordinate: coordinate, title: address)
        mapViewElements.mapView.addAnnotation(pin)
        isUserLocationObtained = true
        calloutElements.addressLabel.text = address
        
        // Zooming on annotation
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapViewElements.mapView.setRegion(region, animated: true)
        
        mapViewElements.mapView.selectAnnotation(pin, animated: true)
    }
    
    
    func failedToObtainLocation(_ error: Error) {
        isUserLocationObtained = false
        print("Failed to obtain location: \(error.localizedDescription)")
    }
    

    // Helper methods related to setting up views
    
    func setupNavigationBar() {
        navigationItem.title = "RSR Pechhulp"
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "terug_normal")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "terug_normal")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    // alert the user to check internet connection
    func showNetworkAlert() {
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
    
    
    
    // alert the user in case of denied permission
    func showPermissionAlert() {
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
    
    
    
    func hideElements() {
        UIView.transition(with: calloutElements.calloutView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.calloutElements.calloutView.isHidden = true
        })
    }
    
    
    func showElements() {
        UIView.transition(with: calloutElements.calloutView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.calloutElements.calloutView.isHidden = false
        })
    }
    
}
