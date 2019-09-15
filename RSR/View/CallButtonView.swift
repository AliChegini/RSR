//
//  CallButtonView.swift
//  RSR
//
//  Created by Ehsan on 15/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

class CallButtonView: UIView {

    let callButton: UIButton = {
        
        let button = UIButton()
        let iconImage = UIImage(named: "ic_phone")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Bel RSR nu", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.setBackgroundImage(UIImage(named: "btn_normal"), for: .normal)
        button.setImage(iconImage, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 150)
        button.addTarget(self, action: #selector(callRSR), for: .touchUpInside)
        
        return button
    }()
    
    
    
    @objc func callRSR() {
        // implementation in MapViewController
    }
    
}
