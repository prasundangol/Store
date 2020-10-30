//
//  OrderConfirmedViewController.swift
//  Store
//
//  Created by MacBook Air on 10/31/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class OrderConfirmedViewController: UIViewController {

    @IBOutlet weak var exploreMoreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        exploreMoreButton.layer.masksToBounds = false
//        exploreMoreButton.clipsToBounds = false
//        exploreMoreButton.layer.shadowOpacity = 0.3
//        exploreMoreButton.layer.shadowRadius = 3
//        exploreMoreButton.layer.shadowOffset = CGSize(width: 2, height: 3)
//        exploreMoreButton.layer.shadowColor = UIColor.systemGreen.cgColor
    }
    
    @IBAction func exploreMoreTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        self.view.window?.rootViewController = initial
        self.view.window?.makeKeyAndVisible()
    }
    

}
