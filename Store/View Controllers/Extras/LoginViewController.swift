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
    
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    static let identifier = "LoginViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        logoImage.image = UIImage(named: "logo")
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setUpElements(){
        errorLabel.alpha = 0
        
        //Styling the elements
        Utility.styleTextField(emailTextField)
        Utility.styleTextField(passwordTextField)
        //Utility.buttonStyling(button: loginButton)
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 25
        loginButton.tintColor = .black
        loginButton.buttonStyling()
        Utility.styleHollowButton(signUpButton)
        
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        self.errorLabel.alpha = 0
        activityIndicator.startAnimating()
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                self.errorLabel.text = "Incorrect Email or Password"
                self.errorLabel.alpha = 1
                self.activityIndicator.stopAnimating()
            }
            else{
                self.activityIndicator.stopAnimating()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initial = storyboard.instantiateInitialViewController()
                self.view.window?.rootViewController = initial
                self.view.window?.makeKeyAndVisible()
            }

        }
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
    }
    

    
}

