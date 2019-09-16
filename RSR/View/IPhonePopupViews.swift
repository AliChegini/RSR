//
//  IPhonePopupViews.swift
//  RSR
//
//  Created by Ehsan on 15/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

class IPhonePopupViews: UIView {

    // all the UI elements for popup
    
    // title label
    let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Belkosten"
        
        return label
    }()
    
    
    // message label
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Voor dit nummer betaalt u uw gebruikelijke belkosten."
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    
    
    // ring button
    let ringButton: UIButton = {
        let button = UIButton()
        let iconImage = UIImage(named: "ic_call")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Bel nu", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.setBackgroundImage(UIImage(named: "btn_normal"), for: .normal)
        button.setImage(iconImage, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 150)
        button.addTarget(self, action: #selector(confirmedCallRSR), for: .touchUpInside)
        
        return button
    }()
    
    
    
    // cancel button
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "annuleren_normal"), for: .normal)
        button.setTitle("Annuleren", for: .normal)
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        return button
    }()
    
    
    // the box view which contains all the popup elements
    let popupBox: UIView = {
      let box = UIView()
        // by default box is hidden until is needed to show
        box.isHidden = true
        box.translatesAutoresizingMaskIntoConstraints = false
        if let backgroundImage = UIImage(named: "popup_back") {
            box.backgroundColor = UIColor(patternImage: backgroundImage)
        }
        return box
    }()
    
    
    // function to setup views
    func setupViews(view: UIView) {
        
        // add all elemets to popup box
        popupBox.addSubview(titleLabel)
        popupBox.addSubview(messageLabel)
        popupBox.addSubview(ringButton)
        popupBox.addSubview(cancelButton)
        
        // add popup box to the view
        view.addSubview(popupBox)
        
        
        NSLayoutConstraint.activate([
            
            // autolayout constraint for titleLabel
            titleLabel.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: popupBox.topAnchor, constant: 30),
            
            // autolayout constraint for messageLabel
            messageLabel.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: popupBox.centerYAnchor),
            messageLabel.widthAnchor.constraint(equalTo: popupBox.widthAnchor),
            
            // autolayout constraint for cancelButton
            cancelButton.topAnchor.constraint(equalTo: popupBox.topAnchor, constant: 0),
            cancelButton.leftAnchor.constraint(equalTo: popupBox.leftAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            cancelButton.heightAnchor.constraint(equalToConstant: 25),
            
            // autolayout constraint for ringButton
            ringButton.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor),
            ringButton.bottomAnchor.constraint(equalTo: popupBox.bottomAnchor, constant: -20),
            ringButton.widthAnchor.constraint(equalTo: popupBox.widthAnchor, constant: -40),
            
            // autolayout constraint for popupBox
            popupBox.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            popupBox.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40),
            popupBox.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupBox.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
            ])
        
    }
    
    
    
    @objc func confirmedCallRSR() {
        // implementation in MapViewController
    }
    
    
    @objc func cancelAction() {
        // implementation in MapViewController
    }
    
}
