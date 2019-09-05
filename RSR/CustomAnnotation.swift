//
//  CustomAnnotation.swift
//  RSR
//
//  Created by Ehsan on 05/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit
import MapKit


// To display an annotation on a map, app must provide two distinct objects:
// an annotation object (CustomAnnotation.swift) and an annotation view (CustomAnnotationView.swift)

// TODO: clean up the folder structure


// class to model annotation object

class RSRAnnotation: NSObject, MKAnnotation {
    @objc dynamic var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }
}



