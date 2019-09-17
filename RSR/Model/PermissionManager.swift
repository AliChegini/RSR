//
//  PermissionManager.swift
//  RSR
//
//  Created by Ehsan on 05/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import Foundation
import CoreLocation


// Requesting permission and location are two separate tasks
// hence two protocols are defined in two different classes
// LocationManagerDelegate and PermissionManagerDelegate

protocol PermissionManagerDelegate: class {
    func authorizationSucceeded()
    func authorizationFailedWithStatus(_ status: CLAuthorizationStatus)
}


class PermissionManager: NSObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    
    weak var permissionDelegate: PermissionManagerDelegate?
    
    override init() {
        super.init()
        
        manager.delegate = self
        
    }
    
    
    func requestPermission() throws {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus == .restricted || authorizationStatus == .denied {
            throw RSRErrors.disallowedByUser
        } else if authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else {
            return
        }
    }
    
    
}

