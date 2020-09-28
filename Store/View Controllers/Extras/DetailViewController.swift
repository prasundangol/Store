//
//  DetailViewController.swift
//  Store
//
//  Created by MacBook Air on 9/18/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class DetailViewController: UIViewController {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var item = ItemModel()
    static let identifier = "DetailViewController"
    private let userId = Auth.auth().currentUser
    private let ref = Database.database().reference().child("Cart")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        styling()
    }
    
    private func configure(){
        guard let url = URL(string: item.Photo!) else { return }
        itemImage.sd_setImage(with: url, placeholderImage: nil, options: .highPriority)
        titleLabel.text = item.Name
        priceLabel.text = ("Rs. ")+(item.Price!)
        quantityLabel.text = "1"
        let totalPrice = Int(String(item.Price!))! * Int(String(quantityLabel.text!))!
        totalPriceLabel.text = ("Rs. ") + String(totalPrice)
        guard let stock = item.Stock else {return}
        if stock {
            stockLabel.textColor = .systemGreen
            stockLabel.text = "In Stock"
        }
        else{
            stockLabel.textColor = .systemRed
            stockLabel.text = "Out of Stock"
        }
       
    }
    
    private func styling(){
        addToCartButton.clipsToBounds = true
        addToCartButton.layer.masksToBounds = true
        addToCartButton.layer.cornerRadius = 25
        addToCartButton.buttonStyling()

        Utility.styleIncreaseButton(increaseButton)
        Utility.styleDecreaseButton(decreaseButton)
        priceLabel.textColor = .systemGreen
        
        //Styling Upper View
        upperView.clipsToBounds = false
        upperView.layer.masksToBounds = false
        upperView.layer.cornerRadius = 40
        upperView.layer.shadowColor = UIColor.lightGray.cgColor
        upperView.layer.shadowOffset = CGSize(width: 2, height: 3)
        upperView.layer.shadowRadius = 5
        upperView.layer.shadowOpacity = 0.5
        
    }
    
    
    
    private func sendToCart(){
        if let user = userId{
            let uid = user.uid
            
            let price = Int(item.Price!)! * Int(quantityLabel.text!)!
            let add = ["Name": item.Name!,
                       "Price": String(price),
                       "Photo": item.Photo!,
                       "ProductId": item.ProductId!,
                       "Quantity": quantityLabel.text!
                        ]
            ref.child(uid).child(item.Name!).setValue(add)
            addedToCartAlert()
            
        }
        
    }
    
    private func addedToCartAlert(){
        let alert = UIAlertController(title: "Added To Cart", message: "", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        // delays execution of code to dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
            alert.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
            
        })
        
        
    }
    

    @IBAction func decreaseButtonTapped(_ sender: Any) {
        if Int(quantityLabel.text!)! > 1{
            let temp = Int(quantityLabel.text!)! - Int(1)
            quantityLabel.text = String(temp)
            let totalPrice = Int(String(item.Price!))! * Int(String(quantityLabel.text!))!
            totalPriceLabel.text = ("Rs. ") + String(totalPrice)
        }
        
    }
    
    
    @IBAction func increaseButtonTapped(_ sender: Any) {
        if Int(quantityLabel.text!)! < 100{
            let temp = Int(quantityLabel.text!)! + Int(1)
            quantityLabel.text = String(temp)
            let totalPrice = Int(String(item.Price!))! * Int(String(quantityLabel.text!))!
            totalPriceLabel.text = ("Rs. ") + String(totalPrice)
        }
    }
    
    
    @IBAction func addToCartTapped(_ sender: Any) {
        guard let stock = item.Stock else {return}
        guard let _ = userId else{
            Utility.alert(title: "Cannot Add To Cart", msg: "You must login to add products to cart.", viewcontroller: self)
            return
        }
        if stock{
            sendToCart()
        }
        else{
            Utility.alert(title: "Out Of Stock", msg: "Sorry! The product is out of stock.", viewcontroller: self)
        }
    }
    
    
}

