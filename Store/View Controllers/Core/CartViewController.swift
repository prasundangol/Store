//
//  CartViewController.swift
//  Store
//
//  Created by MacBook Air on 9/7/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import FirebaseAuth

class CartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cart"
        Utility.checkIfUserIsLoggedIn(viewController: self)
        }
    
    
    
    @IBAction func logout(_ sender: Any) {
        do {
                   try Auth.auth().signOut()
               }
               catch let signOutError as NSError {
                   print ("Error signing out: %@", signOutError)
               }
               
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let initial = storyboard.instantiateInitialViewController()
               self.view.window?.rootViewController = initial
               self.view.window?.makeKeyAndVisible()
    }
    
}
    
