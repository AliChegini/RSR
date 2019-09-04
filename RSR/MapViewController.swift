//
//  MapViewController.swift
//  RSR
//
//  Created by Ehsan on 03/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, LocationManagerDelegate {
    
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
    
    
    private let manager = LocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupViews()
        
        manager.locationDelegate = self
        
        manager.requestPermission()
        manager.requestLocation()
    }
    
    
    @objc func callRSR() {
        let number = "00319007788990"
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    
    func obtainedLocation(_ address: String) {
        print(address)
    }
    
    func failedToObtainLocation(_ error: Error) {
        print("This is the error: \(error.localizedDescription)")
    }
    

}




extension MapViewController {
    
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
