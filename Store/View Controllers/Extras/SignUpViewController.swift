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
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        activityIndicator.hidesWhenStopped = true
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPassword.delegate = self
        phoneNumber.delegate = self
        locationTextField.delegate = self
        styling()
    }
    
    private func styling(){
        firstNameTextField.notSelected()
        lastNameTextField.notSelected()
        emailTextField.notSelected()
        passwordTextField.notSelected()
        confirmPassword.notSelected()
        phoneNumber.notSelected()
        locationTextField.notSelected()
        signUpButton.clipsToBounds = true
        signUpButton.layer.masksToBounds = true
        signUpButton.layer.cornerRadius = 25
        signUpButton.buttonStyling()
        
        if #available(iOS 12, *) {
            // iOS 12 & 13: Not the best solution, but it works.
            passwordTextField.textContentType = .oneTimeCode
            confirmPassword.textContentType = .oneTimeCode
        } else {
            // iOS 11: Disables the autofill accessory view.
            emailTextField.textContentType = .init(rawValue: "")
            passwordTextField.textContentType = .init(rawValue: "")
            confirmPassword.textContentType = .init(rawValue: "")
        }
        
        //Upper View Styling
        upperView.clipsToBounds = false
        upperView.layer.cornerRadius = 25
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
        
        activityIndicator.startAnimating()
        errorLabel.alpha = 0
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
        activityIndicator.stopAnimating()
        errorLabel.alpha = 1
        
    }
    
    func transitionToStore(){
        activityIndicator.stopAnimating()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        self.view.window?.rootViewController = initial
        self.view.window?.makeKeyAndVisible()
        
    }

}

extension SignUpViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField{
            emailTextField.paddingLeft()
        }
        if textField == passwordTextField{
            passwordTextField.paddingLeft()
        }
        
        if textField == firstNameTextField{
            firstNameTextField.paddingLeft()
        }
        if textField == lastNameTextField{
            lastNameTextField.paddingLeft()
        }
        if textField == confirmPassword{
            confirmPassword.paddingLeft()
        }
        if textField == locationTextField{
            locationTextField.paddingLeft()
        }
        if textField == phoneNumber{
            phoneNumber.paddingLeft()
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        firstNameTextField.notSelected()
        lastNameTextField.notSelected()
        emailTextField.notSelected()
        passwordTextField.notSelected()
        confirmPassword.notSelected()
        phoneNumber.notSelected()
        locationTextField.notSelected()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
        
    }
    
}
