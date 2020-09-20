//
//  Utility.swift
//  Store
//
//  Created by MacBook Air on 9/12/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class Utility{
    static func alert(title: String, msg: String, viewcontroller: UIViewController){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil ))
        viewcontroller.present(alert, animated: true)
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
        
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.systemOrange
    }
    
    static func styleDecreaseButton(_ button: UIButton){
        button.clipsToBounds = true
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.tintColor = UIColor.systemBackground
    }
    
    static func styleIncreaseButton(_ button: UIButton){
        button.clipsToBounds = true
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.tintColor = UIColor.systemBackground
    }
    
    static func checkIfUserIsLoggedIn(viewController: UIViewController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let window = UIWindow(frame: UIScreen.main.bounds)
        if Auth.auth().currentUser == nil{
            let vc = storyboard.instantiateViewController(withIdentifier: LoginViewController.identifier) as! LoginViewController
            let navigationController = viewController.navigationController
            navigationController?.pushViewController(vc, animated: true)
            window.makeKeyAndVisible()
        }
    }
    
}
