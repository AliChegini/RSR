//
//  LocationManager.swift
//  RSR
//
//  Created by Ehsan on 04/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import Foundation
import CoreLocation


// Requesting permission and location are two separate tasks
// hence two protocols are defined in two different classes
// LocationManagerDelegate and PermissionManagerDelegate

protocol LocationManagerDelegate: class {
    func obtainedLocation(_ address: String, _ coordinate: CLLocationCoordinate2D)
    func failedToObtainLocation(_ error: Error)
}


class LocationManager: NSObject {
    
    private let manager = CLLocationManager()
    
    weak var locationDelegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        
        manager.delegate = self
    }
    
    
    func requestLocation() {
        manager.requestLocation()
    }
    
}



extension LocationManager: CLLocationManagerDelegate {
    
    // MARK: CLLocationManagerDelegate methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        
        // determining the address using the obtained location(coordinates)
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemark, error) in
            if let placemark = placemark {
                var stringAddress = ""
                guard let info = placemark.first else {
                    // TODO: could not find placemarks
                    return
                }
                
                // constructing string address to show user
                
                if let streetName = info.thoroughfare {
                    stringAddress += "\(streetName), "
                }
                
                
                if let postCode = info.postalCode {
                    stringAddress += "\(postCode), "
                }
            
                
                if let city = info.locality {
                    stringAddress +=  "\(city)"
                }
                
                // sending the obtained address via delegate to MapViewController
                self.locationDelegate?.obtainedLocation(stringAddress, location.coordinate)
                
            }
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationDelegate?.failedToObtainLocation(error)
    }
}

