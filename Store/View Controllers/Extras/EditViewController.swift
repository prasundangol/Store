//
//  EditViewController.swift
//  Store
//
//  Created by MacBook Air on 11/5/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class EditViewController: UIViewController {
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var saveChanges: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var Info = AccountModel()
    var tag = Int()
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .systemGreen
        activityIndicator.hidesWhenStopped = true
        styling()
        firstTextField.delegate = self
        secondTextField.delegate = self
        thirdTextField.delegate = self
        locationTextField.delegate = self
        errorLabel.alpha = 0
        
        if tag == 1{
            self.title = "Edit Profile"
            setUpEditProfile()
        }
        else{
            self.title = "Change Password"
            locationTextField.isHidden = true
            setUpChangePassword()
        }
        
    }
    
    private func styling(){
        //Button Styling
        saveChanges.clipsToBounds = true
        saveChanges.layer.masksToBounds = true
        saveChanges.layer.cornerRadius = 25
        saveChanges.buttonStyling()
        
        //TextField Styling
        firstTextField.notSelected()
        secondTextField.notSelected()
        thirdTextField.notSelected()
        locationTextField.notSelected()
        
        if tag == 2{
            firstTextField.isSecureTextEntry = true
            secondTextField.isSecureTextEntry = true
            thirdTextField.isSecureTextEntry = true
        }
    }
    
    private func setUpEditProfile(){
        firstTextField.text = Info.fName ?? ""
        secondTextField.text = Info.lName ?? ""
        thirdTextField.text = Info.phno ?? ""
        locationTextField.text = Info.location ?? ""
        
    }
    
    private func setProfileData(){
        //Editing the profile
        let error = validateFields()
        
        if error != nil{
            //Show error
            showError(error!)
        }
        else{
            let firstname = firstTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = secondTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phno = thirdTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let location = locationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let add = ["firstname": firstname,
                       "lastname": lastname,
                       "phno": phno,
                       "location": location
                        ]
            
            
            db.collection("users").whereField("uid", isEqualTo: user!.uid).getDocuments { (snapshot, error) in
                if let _ = error{
                    print("Error")
                }
                guard let snapshot = snapshot else {return}
                for document in snapshot.documents{
                    let id = document.documentID
                    self.db.collection("users").document(id).setData(add, merge: true) { (error) in
                        if error != nil{
                            print("There was an error")
                            return
                        }
                        self.activityIndicator.stopAnimating()
                        
                        Utility.sucessfulAlert(title: "Edit Profile Successful", navigation: self.navigationController!, viewcontroller: self)
                        
                    }
                }
            }
        }
    }
    
    private func setUpChangePassword(){
        firstTextField.placeholder = "Current Password"
        secondTextField.placeholder = "New Password"
        thirdTextField.placeholder = "Confirm Password"
    }
    
    private func validateFields() -> String? {
        if tag == 1{
        if firstTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            secondTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            thirdTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            locationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please Fill All Fields"
        }
        }
        
        if tag == 2{
            if firstTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                secondTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                thirdTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
                
                return "Please Fill All Fields"
            }
            
            //Validiting email and password
            let cleanedPassword = secondTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanedConfPassword = thirdTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if Utility.isPasswordValid(cleanedPassword) == false{
                //Password isn't secure enough
                return "Please make sure your passowrd is 8 charachers, contains a special character and a number"
                
            }
            
            if cleanedPassword != cleanedConfPassword{
                return "Passwords Does Not Match"
            }
        }
        return nil
        
    }
    
    private func setPasswordData(){
        //Editing the profile
        let error = validateFields()
        
        if error != nil{
            //Show error
            showError(error!)
        }
        else{
            let currentPassword = firstTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let newPassword = secondTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let credintial = EmailAuthProvider.credential(withEmail: (user?.email)!, password: currentPassword)
            
            user?.reauthenticate(with: credintial, completion: { (result, error) in
                if error != nil{
                    self.showError("Your current password is incorrect.")
                }
                else{
                    self.user?.updatePassword(to: newPassword, completion: { (result) in
                        //Suscessful
                        self.activityIndicator.stopAnimating()
                        Utility.sucessfulAlert(title: "Password Changed", navigation: self.navigationController!, viewcontroller: self)
                    })
                }
            })
        }
        
        
    }
    private func showError(_ message: String){
        errorLabel.text = message
        activityIndicator.stopAnimating()
        errorLabel.alpha = 1
        
    }
    
    @IBAction func saveChangesTapped(_ sender: Any) {
        errorLabel.alpha = 0
        activityIndicator.startAnimating()
        if tag == 1{
            setProfileData()
        }
        else{
            setPasswordData()
        }
    }
    
}

extension EditViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == firstTextField{
            firstTextField.paddingLeft()
        }
        if textField == secondTextField{
            secondTextField.paddingLeft()
        }
        if textField == thirdTextField{
            thirdTextField.paddingLeft()
        }
        if textField == locationTextField{
            locationTextField.paddingLeft()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.notSelected()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
        
    }
}
