//
//  MainViewController.swift
//  RSR
//
//  Created by Ehsan on 03/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // All the UI elements for this view, and a function to
    // setup the autolayout constraints are included in mainViewElements
    let mainViewElements = MainViews()
    
    
    // defaults to save user consent on privacy policy
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        mainViewElements.setupViews(view: view)
        
        // check user defaults for privacy consent
        // show alert if consent is missing
        if !defaults.bool(forKey: "PrivacyConsent") {
            showPrivacyAlert()
        }
    }
    
    
    
    @objc func showMap() {
        let mapVC = MapViewController()
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    
    @objc func showPrivacyPolicy() {
        showPrivacyAlert()
    }

}



extension MainViewController {
    
    func setupNavigationBar() {
        
        navigationItem.title = "RSR Revalidatieservice"
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navig_bar_back"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            // check if device is phone show rightBarButton and hide aboutButton
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_over")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showPrivacyPolicy))
            mainViewElements.aboutButton.isHidden = true
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            mainViewElements.aboutButton.isHidden = false
        }
       
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    func showPrivacyAlert() {
        
        let alert = UIAlertController(title: nil, message: "Om gebruik te maken van deze app dient u het privacybeleid te accepteren", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Accepteren", style: .default, handler: { (action) in
            // save in user defaults
            self.defaults.set(true, forKey: "PrivacyConsent")
        }))
        
        alert.addAction(UIAlertAction(title: "Ga naar privacybeleid", style: .default, handler: { (action) in
            // open link in browser
            if let url = URL(string: "https://www.rsr.nl/index.php?page=privacy-wetgeving") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
