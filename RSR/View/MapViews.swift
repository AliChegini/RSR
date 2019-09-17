//
//  MapViews.swift
//  RSR
//
//  Created by Ehsan on 16/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit
import MapKit

class MapViews: UIView {

    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.showsUserLocation = true
        
        return map
    }()
    
    
    let callButton: UIButton = {
        
        let button = UIButton()
        let iconImage = UIImage(named: "ic_phone")
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
    
    
    
    func setupViews(view: UIView) {
        
        view.addSubview(mapView)
        view.addSubview(callButton)
        
        NSLayoutConstraint.activate([
            
            // auto layout constraint for map view
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor),
            mapView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            
            // auto layout constraint for assistance button
            callButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            callButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            callButton.heightAnchor.constraint(equalToConstant: 70.0),
            callButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40)
            
            ])
        
    }
    
    
    
    @objc func callRSR() {
        // implementation in MapViewController
    }
    

}
