//
//  MapViewController.swift
//  RSR
//
//  Created by Ehsan on 03/09/2019.
//  Copyright © 2019 Ali C. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        navigationItem.title = "RSR Pechhulp"
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "terug_normal")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "terug_normal")?.withRenderingMode(.alwaysOriginal)
        
        // TODO: remove text from back button
        
        //navigationItem.leftItemsSupplementBackButton = true
        //navigationItem.backBarButtonItem?.title = ""
        
    }
    

}
