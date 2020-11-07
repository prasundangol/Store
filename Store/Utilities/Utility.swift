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
        button.layer.masksToBounds = false
        button.clipsToBounds = false
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 3)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
        
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.systemOrange
        button.layer.masksToBounds = false
        button.clipsToBounds = false
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 3)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
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
            navigationController?.pushViewController(vc, animated: false)
            window.makeKeyAndVisible()
        }
    }
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.systemGreen.cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
         
         let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
         return passwordTest.evaluate(with: password)
     }
     
    static func isValidEmail(_ email: String) -> Bool {
         let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

         let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
         return emailPred.evaluate(with: email)
     }
    
    static func stylingCollectionViewCell(cell: UICollectionViewCell){
        cell.layer.masksToBounds = false
        cell.clipsToBounds = false
        cell.backgroundColor = .systemBackground
        cell.layer.cornerRadius = 25
        //cell.backgroundGradient()

        
        //Shadows
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize(width: 2, height: 3)
        cell.layer.shadowRadius = 5
    }
    
    static func normalTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.systemGray2.cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func notifyAlert(title: String, viewcontroller: UIViewController){
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        viewcontroller.present(alert, animated: true, completion: nil)
        
        // delays execution of code to dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
            alert.dismiss(animated: true, completion: nil)
            viewcontroller.dismiss(animated: true, completion: nil)
            
        })
    }
    
    static func sucessfulAlert(title: String, navigation: UINavigationController, viewcontroller: UIViewController){
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        viewcontroller.present(alert, animated: true, completion: nil)
        
        // delays execution of code to dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
            alert.dismiss(animated: true, completion: nil)
            navigation.popViewController(animated: false)
            
        })
    }
}

extension UIView{
     func buttonStyling(){
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        let color1 = UIColor(red: 244.0/255.0, green: 208/255.0, blue: 63.0/255.0, alpha: 1.0)
        let color2 = UIColor(red: 22.0/255.0, green: 160.0/255.0, blue: 133.0/255.0, alpha: 1.0)
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0,1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradient, at: 0)

    }
    
    func backgroundGradient(){
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        let color1 = UIColor(red: 244.0/255.0, green: 208/255.0, blue: 63.0/255.0, alpha: 1.0)
        let color2 = UIColor(red: 22.0/255.0, green: 160.0/255.0, blue: 133.0/255.0, alpha: 1.0)
        gradient.colors = [UIColor.systemGreen.cgColor, UIColor.systemGray6.cgColor]
        gradient.locations = [0.0,1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradient, at: 0)
        
    }
    
}

extension UITextField{
    func paddingLeft(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.borderStyle = .none
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemGreen.cgColor
        
    }
    
    func notSelected(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.borderStyle = .none
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemGray4.cgColor
        
    }
    
}

extension UIButton {
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        //NSAttributedStringKey.foregroundColor : UIColor.blue
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}


