//
//  SignUpViewController.swift
//  Store
//
//  Created by MacBook Air on 9/22/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        styling()
    }
    
    private func styling(){
        Utility.styleTextField(firstNameTextField)
        Utility.styleTextField(lastNameTextField)
        Utility.styleTextField(emailTextField)
        Utility.styleTextField(passwordTextField)
        Utility.styleTextField(confirmPassword)
        Utility.styleTextField(phoneNumber)
        Utility.styleTextField(locationTextField)
        Utility.styleFilledButton(signUpButton)
    }
    
    private func validateFields() -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            locationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            phoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please Fill All Fields"
        }
        
        //Validiting email and password
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedConfPassword = confirmPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utility.isPasswordValid(cleanedPassword) == false{
            //Password isn't secure enough
            return "Please make sure your passowrd is 8 charachers, contains a special character and a number"
            
        }
        
        if Utility.isValidEmail(cleanedEmail) == false{
            return "Email is not valid"
        }
        
        if cleanedPassword != cleanedConfPassword{
            return "Passwords Does Not Match"
        }
        
        return nil
        
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil{
            showError(error!)
        }
        else{
            let firstname = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let location = locationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phno = phoneNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //Check for erros
                if err != nil{
                    //There was an error
                    self.showError("The user already exits")
                      
                }
                else{
                    //User was corrected successfully and store data
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname": firstname ,"lastname":lastname ,"location": location ,"phno":phno ,"uid": result!.user.uid]) { (error) in
                        if error != nil{
                            //Show error message
                            self.showError("Error while saving data")
                            
                        }
                    }
                    
                    //Transition to the home screen
                    self.dismiss(animated: true, completion: nil)
                    self.transitionToStore()
                    
                }
            }
        }
    }
    
    private func showError(_ message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    
    func transitionToStore(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        self.view.window?.rootViewController = initial
        self.view.window?.makeKeyAndVisible()
        
    }

}
