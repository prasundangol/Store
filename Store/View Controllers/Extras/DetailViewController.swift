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
    var cartItem = CartModel()
    var tag = Int()
    var price = Int()
    var totalPrice = Int()
    static let identifier = "DetailViewController"
    private let userId = Auth.auth().currentUser
    private let ref = Database.database().reference().child("Cart")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        styling()
    }
    
    private func configure(){
        if tag == 1{
            guard let url = URL(string: cartItem.Photo!) else { return }
            itemImage.sd_setImage(with: url, placeholderImage: nil, options: .highPriority)
            titleLabel.text = cartItem.Name
            quantityLabel.text = cartItem.Quantity
            price = Int(cartItem.Price!)! / Int(cartItem.Quantity!)!
            priceLabel.text = ("Rs. ")+(String(price))
            totalPriceLabel.text = ("Rs. ") + String(cartItem.Price!)
            stockLabel.text = "In Stock"
            stockLabel.textColor = .systemGreen
        }
        else{
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
        
        if tag == 1{
            addToCartButton.setTitle("Update", for: .normal)
        }
        
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
            Utility.notifyAlert(title: "Added to Cart", viewcontroller: self)
            
            
        }
        
    }
    
    private func updateCart(){
            if let user = userId{
                let uid = user.uid
                
                let add = ["Price": String(totalPrice),
                           "Quantity": quantityLabel.text ?? "1",
                    ] 
                
                ref.child(uid).child(cartItem.Name!).updateChildValues(add as [AnyHashable : Any])
                Utility.notifyAlert(title: "Updated", viewcontroller: self)
            }
    }
    
    

    @IBAction func decreaseButtonTapped(_ sender: Any) {
        if Int(quantityLabel.text!)! > 1{
            let temp = Int(quantityLabel.text!)! - Int(1)
            quantityLabel.text = String(temp)
            if tag == 1{
                totalPrice = price * temp
                totalPriceLabel.text = ("Rs. ") + String(totalPrice)

            }
            else{
                let totalPrice = Int(String(item.Price!))! * Int(String(quantityLabel.text!))!
                totalPriceLabel.text = ("Rs. ") + String(totalPrice)
            }
        }
        
    }
    
    
    @IBAction func increaseButtonTapped(_ sender: Any) {
        if Int(quantityLabel.text!)! < 100{
            let temp = Int(quantityLabel.text!)! + Int(1)
            quantityLabel.text = String(temp)
            if tag == 1{
                totalPrice = price * temp
                totalPriceLabel.text = ("Rs. ") + String(totalPrice)
            }
            else{
                let totalPrice = Int(String(item.Price!))! * Int(String(quantityLabel.text!))!
                totalPriceLabel.text = ("Rs. ") + String(totalPrice)
            }
        }
    }
    
    
    @IBAction func addToCartTapped(_ sender: Any) {
        if tag == 1{
            updateCart()
        }
        else{
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
}

