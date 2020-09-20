//
//  LoginViewController.swift
//  Store
//
//  Created by MacBook Air on 9/19/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    static let identifier = "LoginViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func tapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: "kalu@gmail.com", password: "kalu123@") { (result, error) in
            print(result ?? "Result")
            print(error ?? "Eror")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initial = storyboard.instantiateInitialViewController()
            self.view.window?.rootViewController = initial
            self.view.window?.makeKeyAndVisible()
        }
    }
}
