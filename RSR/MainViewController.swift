//
//  ViewController.swift
//  RSR
//
//  Created by Ehsan on 03/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // UI elements all in code
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "img_background")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    
    let assistanceButton: UIButton = {
       let button = UIButton()
        let iconImage = UIImage(named: "ic_attention")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("RSR Pechhulp", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.setBackgroundImage(UIImage(named: "btn_normal"), for: .normal)
        button.setImage(iconImage, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 150)
        button.addTarget(self, action: #selector(showMap), for: .touchUpInside)
        
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up the navigation bar
        navigationItem.title = "RSR Revalidatieservice"
        navigationController?.navigationBar.barTintColor = UIColor(red: 4.0/255.0, green: 147.0/255.0, blue: 187.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_over_normal")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showAbout))
        
        
        
        setupViews()

    }
    
    
    
    @objc func showMap() {
        let mapVC = MapViewController()
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    
    @objc func showAbout() {
        
    }
    
    
    // function to setup the views and autolayout constraints
    func setupViews() {
        view.addSubview(backgroundImage)
        view.addSubview(assistanceButton)
        
        // auto layout constraint for background image
        backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        // auto layout constraint for assistance button
        assistanceButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        assistanceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        assistanceButton.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        assistanceButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        assistanceButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    
    

}

