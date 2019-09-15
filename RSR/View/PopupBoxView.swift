//
//  PopupBox.swift
//  RSR
//
//  Created by Ehsan on 15/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

class PopupBoxView: UIView {

    // main box which contains all the popup elements
    let popupBox: UIView = {
        
        let popupBox = UIView()
        popupBox.isHidden = true
        popupBox.translatesAutoresizingMaskIntoConstraints = false
        if let backgroundImage = UIImage(named: "popup_back") {
            popupBox.backgroundColor = UIColor(patternImage: backgroundImage)
        }
        
        
        // title lable
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.text = "Belkosten"
        
        
        // message label
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = .white
        messageLabel.font = UIFont.boldSystemFont(ofSize: 16)
        messageLabel.text = "Voor dit nummer betaalt u uw gebruikelijke belkosten."
        messageLabel.numberOfLines = 2
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.textAlignment = .center
        
        
        // ring button
        let ringButton = UIButton()
        let iconImage = UIImage(named: "ic_call")
        ringButton.translatesAutoresizingMaskIntoConstraints = false
        ringButton.setTitle("Bel nu", for: .normal)
        ringButton.titleLabel?.textAlignment = .center
        ringButton.layer.cornerRadius = 10
        ringButton.setBackgroundImage(UIImage(named: "btn_normal"), for: .normal)
        ringButton.setImage(iconImage, for: .normal)
        ringButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
        ringButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 150)
        ringButton.addTarget(self, action: #selector(confirmedCallRSR), for: .touchUpInside)
            
        
        // cancel button
        let cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setBackgroundImage(UIImage(named: "annuleren_normal"), for: .normal)
        cancelButton.setTitle("Annuleren", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
            
            
        // add all elemets to popup box
        popupBox.addSubview(titleLabel)
        popupBox.addSubview(messageLabel)
        popupBox.addSubview(ringButton)
        popupBox.addSubview(cancelButton)
        
        
        // autolayout constraint for inner elements of popupBox
        titleLabel.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: popupBox.topAnchor, constant: 30).isActive = true
        
        messageLabel.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: popupBox.centerYAnchor).isActive = true
        messageLabel.widthAnchor.constraint(equalTo: popupBox.widthAnchor).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: popupBox.topAnchor, constant: 0).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: popupBox.leftAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        ringButton.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor).isActive = true
        ringButton.bottomAnchor.constraint(equalTo: popupBox.bottomAnchor, constant: -20).isActive = true
        ringButton.widthAnchor.constraint(equalTo: popupBox.widthAnchor, constant: -40).isActive = true
        
        
        return popupBox
    }()
    
    
    
    @objc func confirmedCallRSR() {
        // implementation in MapViewController
    }
    
    
    @objc func cancelAction() {
        // implementation in MapViewController
    }
    
}
