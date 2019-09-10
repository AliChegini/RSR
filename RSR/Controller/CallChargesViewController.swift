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
        return label
    }()
    
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let ringButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        
    }
    
    
    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(cancelButton)
        view.addSubview(ringButton)
        
        
        
        
        
    }
    

}
