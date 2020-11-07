//
//  CheckoutViewController.swift
//  Store
//
//  Created by MacBook Air on 10/1/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var totalMrpLabel: UILabel!
    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var cashOnDeliveryButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    var checkOutItems = [CartModel]()
    var mrpPrice = Int()
    var vat = Int()
    var totalPrice = Int()
    
    let ref = Database.database().reference().child("orders")
    let userId = Auth.auth().currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Checkout"
        cashOnDeliveryButton.isSelected = true
        priceCalculations()
        configure()
    }
    
    private func priceCalculations(){
        vat = Int(0.13 * Double((mrpPrice)))
        totalPrice = vat + mrpPrice
    }
    
    private func configure(){
        //Continue button Styling
        continueButton.clipsToBounds = true
        continueButton.layer.masksToBounds = true
        continueButton.layer.cornerRadius = 25
        continueButton.buttonStyling()
        
        totalMrpLabel.text = "Rs. " + String(mrpPrice)
        vatLabel.text = "Rs. " + String(vat)
        totalPriceLabel.text = "Rs. " + String(totalPrice)
    }
    
    private func checkout(){
        let cartRef = Database.database().reference().child("Cart")
        if let user = userId{
            let uid = user.uid
            let time = getDate()
            let dateData = Date().timeIntervalSince1970
            let timestamp = Int(-dateData)
            var payment = String()
            
            if cashOnDeliveryButton.isSelected == true{
                payment = "Cash on Delivery"
            }
            
            for item in checkOutItems{
                let add = ["Name": item.Name,
                           "Price": item.Price,
                           "Quantity": item.Quantity,
                           "ProductId": item.ProductId,
                           "payment": payment
                           ]
                ref.child(uid).child(time).child("data").child(item.Name!).setValue(add)
                ref.child(uid).child(time).child("data").child("timestamp").setValue(timestamp)
                cartRef.child(uid).removeValue()
            }
            
        }
    }
    
    private func getDate() -> String{
        let currentDate = Date()
        
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        
        let dateTimeString = formatter.string(from: currentDate)
        
        return dateTimeString
    }
    
    
    @IBAction func didTapCashOnDelivery(_ sender: UIButton) {
        if sender.isSelected{
            //Deselect other options
            
        }else{
            sender.isSelected = true
        }
        
    }
    
    @IBAction func didTapContinue(_ sender: Any) {
        orderedAlert()
    }
    
    private func orderedAlert(){
        let alert = UIAlertController(title: "Confirm", message: "Press confirm to place your order.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) in
            self.checkout()
//            Utility.notifyAlert(title: "Your order is on its way.", viewcontroller: self)
            
             //Goto store view controller
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let initial = storyboard.instantiateInitialViewController()
//                self.view.window?.rootViewController = initial
//                self.view.window?.makeKeyAndVisible()
//            }
            
            self.performSegue(withIdentifier: Consatnts.checkoutToOrderConfirmed, sender: nil)
            
        }))
        
        self.present(alert, animated: true)
    }
    
}
