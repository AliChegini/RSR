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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        mainViewElements.setupViews(view: view)
        
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

        // TODO: remove the 1 px bottom line from navBar
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            // check if device is phone show rightBarButton and hide aboutButton
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_over")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showAbout))
            mainViewElements.aboutButton.isHidden = true
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            mainViewElements.aboutButton.isHidden = false
        }
       
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}


// Final task list:
// 1. add zoom span logic --- done
// 3. fix button size for small device, it should not expand the button size --- done
// 5. fix custom callout issues --- done
// 4. fix show elements on the map while opoupView is up --- done
// improved code/ folder structure --- done

// 2. fix popupview for ipad/iphone(done) - half done
// continue with simplifying calloutView and clean up

// 6. refactoring and cleanup (half done), fix UI details like small line on navbar
// 7. add privacy alert at first launch : Om gebruik te maken van deze app dient u het privacybeleid te accepteren
