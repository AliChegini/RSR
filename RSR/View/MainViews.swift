//
//  MainViews.swift
//  RSR
//
//  Created by Ehsan on 16/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

class MainViews: UIView {

    // UI elements needed for MainView

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
        button.addTarget(self, action: #selector(showPrivacyPolicy), for: .touchUpInside)

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
    
    
    
    func setupViews(view: UIView) {
        
        view.addSubview(backgroundImage)
        view.addSubview(stackView)

        stackView.addArrangedSubview(assistanceButton)
        stackView.addArrangedSubview(aboutButton)

        
        NSLayoutConstraint.activate([
            
            // auto layout constraint for background image
            backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            // auto layout constraint for stackview(buttons)
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            // auto layout constraint for buttons
            assistanceButton.heightAnchor.constraint(equalToConstant: 70),
            assistanceButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -40),
            
            aboutButton.heightAnchor.constraint(equalToConstant: 70),
            aboutButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -40),
            
            ])
        
    }
    
    
    
    @objc func showMap() {
        // implementation in MainViewController
    }
    
    
    @objc func showPrivacyPolicy() {
        // implementation in MainViewController
    }
    

}
