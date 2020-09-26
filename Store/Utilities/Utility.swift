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
        cell.layer.cornerRadius = 30
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
        //let color1 = UIColor(red: 175/255.0, green: 241/255.0, blue: 218/255.0, alpha: 1.0)
        let color2 = UIColor(red: 250/255.0, green: 238/255.0, blue: 158/255.0, alpha: 1.0)
        gradient.colors = [color2.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.0,1.0]
        gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradient, at: 0)
        
    }
    
}

extension CALayer{
    func addGradientBorder(){
        let gradientLayer = CAGradientLayer()
        let color1 = UIColor(red: 18/255.0, green: 190/255.0, blue: 138/255.0, alpha: 1.0)
        let color2 = UIColor(red: 10/255.0, green: 112/255.0, blue: 168/255.0, alpha: 1.0)
        gradientLayer.frame =  CGRect(origin: .zero, size: self.bounds.size)
        gradientLayer.colors = [color1.cgColor,color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0,y: 0.5)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 4
        shapeLayer.path = UIBezierPath(rect: self.bounds).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        gradientLayer.mask = shapeLayer
        
        self.addSublayer(gradientLayer)
        
    }
    
}

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(0.7))
    }
}
