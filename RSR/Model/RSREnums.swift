//
//  RSREnums.swift
//  RSR
//
//  Created by Ehsan on 05/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import Foundation


enum NetworkStatus {
    case connected
    case notConnected
    case unknown
}


enum RSRErrors: Error {
    case disallowedByUser
}
