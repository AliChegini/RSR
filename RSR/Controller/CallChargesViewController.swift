//
//  CallChargesViewController.swift
//  RSR
//
//  Created by Ehsan on 10/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

class CallChargesViewController: UIViewController {
    
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Belkosten"
        return label
    }()
    
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Voor dit nummer betaalt u uw gebruikelijke belkosten."
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    
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
        button.addTarget(self, action: #selector(callRSR), for: .touchUpInside)
        
        return button
    }()
    
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Annuleren", for: .normal)
        return button
    }()
    
    // UI elements for popup will be added to popupBox view
    let popupBox: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        
        self.definesPresentationContext = true
        
        setupViews()
        
    }
    
    
    @objc func callRSR() {
        let number = "00319007788990"
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    
    func setupViews() {
        view.addSubview(popupBox)
        popupBox.addSubview(titleLabel)
        popupBox.addSubview(messageLabel)
        popupBox.addSubview(ringButton)
        popupBox.addSubview(cancelButton)
        
        // autolayout constraint for popupBox
        popupBox.heightAnchor.constraint(equalToConstant: 200).isActive = true
        popupBox.widthAnchor.constraint(equalToConstant: 300).isActive = true
        popupBox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popupBox.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        // autolayout constraint for inner elements of popupBox
        titleLabel.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: popupBox.topAnchor, constant: 30).isActive = true
        
        messageLabel.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: popupBox.centerYAnchor).isActive = true
        messageLabel.widthAnchor.constraint(equalTo: popupBox.widthAnchor).isActive = true
        
        cancelButton.bottomAnchor.constraint(equalTo: popupBox.topAnchor).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: popupBox.leftAnchor).isActive = true
        
        ringButton.centerXAnchor.constraint(equalTo: popupBox.centerXAnchor).isActive = true
        ringButton.bottomAnchor.constraint(equalTo: popupBox.bottomAnchor, constant: -10).isActive = true

    
    }
    
    

}
