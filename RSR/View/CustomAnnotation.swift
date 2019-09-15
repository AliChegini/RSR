//
//  CustomAnnotation.swift
//  RSR
//
//  Created by Ehsan on 05/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit
import MapKit


// class to model custom annotation object

class CustomAnnotation: NSObject, MKAnnotation {
    
    @objc dynamic var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }
    
}
