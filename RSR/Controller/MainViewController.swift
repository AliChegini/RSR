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
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 100)
        button.addTarget(self, action: #selector(showMap), for: .touchUpInside)
        
        return button
    }()
    
    
    let aboutButton: UIButton = {
        let button = UIButton()
        let iconImage = UIImage(named: "ic_over")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Over RSR", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 10
        button.setBackgroundImage(UIImage(named: "btn_normal"), for: .normal)
        button.setImage(iconImage, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 150)
        button.addTarget(self, action: #selector(showAbout), for: .touchUpInside)
        
        return button
    }()
    
    // stack view to arrange buttons
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = UIStackView.Alignment.center
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 30
        
        return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        assistanceButton.isHidden = false
        setupNavigationBar()
        setupViews()
    }
    
    
    @objc func showMap() {
        let mapVC = MapViewController()
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    
    @objc func showAbout() {
        
    }

}




extension MainViewController {
    
    // setting up the navigation bar
    func setupNavigationBar() {
        navigationItem.title = "RSR Revalidatieservice"
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navig_bar_back"), for: .default)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // check if device is phone show rightBarButton and hide aboutButton
        if UIDevice.current.userInterfaceIdiom == .phone {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_over")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showAbout))
            aboutButton.isHidden = true
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            aboutButton.isHidden = false
        }
        // TODO: fix stack view issues where it expand the button's height
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    // function to setup the views and autolayout constraints
    func setupViews() {
        view.addSubview(backgroundImage)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(assistanceButton)
        stackView.addArrangedSubview(aboutButton)
        
        // auto layout constraint for background image
        backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        // auto layout constraint for stackview
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true

        
        assistanceButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        aboutButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        // auto layout constraint for assistance button
//        assistanceButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
//        assistanceButton.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        
//        assistanceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//        assistanceButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
//        assistanceButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
        
        // auto layout constraint for about button
        //aboutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        aboutButton.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
//        aboutButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
//        aboutButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
//        aboutButton.topAnchor.constraint(equalTo: assistanceButton.bottomAnchor, constant: 30).isActive = true
    }
}
