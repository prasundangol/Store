//
//  MyOrdersViewController.swift
//  Store
//
//  Created by MacBook Air on 9/7/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import FirebaseAuth

class MyOrdersViewController: UIViewController {
    
     let window = UIWindow(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Orders"
        Utility.checkIfUserIsLoggedIn(viewController: self)
    }
    

}
