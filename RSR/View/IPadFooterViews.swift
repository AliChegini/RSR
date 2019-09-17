//
//  IPadFooterViews.swift
//  RSR
//
//  Created by Ehsan on 15/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

class IPadFooterViews: UIView {

    // title label at the top
    let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Neem contact op met RSR Nederland"
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    // phone button in the middle
    let phoneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("0900-7788990", for: .normal)
        button.setImage(UIImage(named: "ic_phone"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(callRSRIpad), for: .touchUpInside)
        
        return button
    }()
    
    
    // message label at bottom
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Voor dit nummer betaalt u uw gebruikelijke belkosten."
        label.textAlignment = .center
        
        return label
    }()
    
    
    // this view contains all the UI elements for footer
    let footerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.0/255.0, green: 146.0/255.0, blue: 187.0/255.0, alpha: 0.7)
        
        return view
    }()
    
    
    
    @objc func callRSRIpad() {
        // implementation in MapViewController
    }
    
    
    
    func setupViews(view: UIView) {
        
        footerView.addSubview(titleLabel)
        footerView.addSubview(phoneButton)
        footerView.addSubview(messageLabel)
        
        view.addSubview(footerView)
        
        
        NSLayoutConstraint.activate([
            
            // autolayout constraint for titleLabel
            titleLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalTo: footerView.widthAnchor),
            
            // autolayout constraint for phoneButton
            phoneButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            phoneButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            phoneButton.widthAnchor.constraint(equalToConstant: 200),
            phoneButton.heightAnchor.constraint(equalToConstant: 50),
            
            // autolayout constraint for messageLabel
            messageLabel.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -30),
            messageLabel.widthAnchor.constraint(equalTo: footerView.widthAnchor),
            
            // autolayout constraint for footerView
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 200)
            
            ])
        
    }
    

}
