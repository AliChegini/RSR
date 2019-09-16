//
//  CalloutViews.swift
//  RSR
//
//  Created by Ehsan on 15/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit
import MapKit

// callout consist of two parts --- static and dynamic
// static : top and bottom labels
// dynamic: address label

class CalloutViews: UIView {
    
    let calloutWithoutAddress: UIImageView = {
        
        let calloutView = UIImageView()
        calloutView.translatesAutoresizingMaskIntoConstraints = false
        calloutView.layer.cornerRadius = 10
        calloutView.layer.masksToBounds = true
        calloutView.image = UIImage(named: "address_back")
        
        
        
        let titleLabel = UILabel()
        titleLabel.text = "Uw locatie:"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        
        
        
        let instructionLabel = UILabel()
        instructionLabel.text = "Onthoud deze locatie voor het telefoongesprek."
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.textAlignment = .center
        instructionLabel.numberOfLines = 2
        instructionLabel.lineBreakMode = .byWordWrapping
        instructionLabel.font = UIFont.systemFont(ofSize: 14)
        instructionLabel.textColor = .white
        
        
        // label at top of the bubble
        calloutView.addSubview(titleLabel)
        // label at bottom of the bubble
        calloutView.addSubview(instructionLabel)
        
        
        
        NSLayoutConstraint.activate([
            
            // auto layout constraints for titleLabel
            titleLabel.centerXAnchor.constraint(equalTo: calloutView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: calloutView.topAnchor, constant: 20),
            
            // auto layout constraints for instructionLabel
            instructionLabel.centerXAnchor.constraint(equalTo: calloutView.centerXAnchor),
            instructionLabel.topAnchor.constraint(equalTo: calloutView.bottomAnchor, constant: -80),
            instructionLabel.widthAnchor.constraint(equalTo: calloutView.widthAnchor)
            
            ])
        
        
        return calloutView
    }()
    
    
    
    let addressLabel: UILabel = {
        
        let addressLabel = UILabel()
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.textAlignment = .center
        addressLabel.numberOfLines = 2
        addressLabel.lineBreakMode = .byWordWrapping
        addressLabel.font = UIFont.systemFont(ofSize: 18)
        addressLabel.textColor = .white
        
        return addressLabel
    }()
    
    
    
    func configureAddressLabel(address: String) {
        addressLabel.text = address
        
        calloutWithoutAddress.addSubview(addressLabel)

        // constraints for addressLabel
        NSLayoutConstraint.activate([
            addressLabel.centerXAnchor.constraint(equalTo: calloutWithoutAddress.centerXAnchor),
            addressLabel.centerYAnchor.constraint(equalTo: calloutWithoutAddress.centerYAnchor),
            addressLabel.widthAnchor.constraint(equalTo: calloutWithoutAddress.widthAnchor)
            ])
        
    }
    

}
