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
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var decreaseButton: UIButton!
    
    var item = ItemModel()
    static let identifier = "DetailViewController"
    private let userId = Auth.auth().currentUser
    private let ref = Database.database().reference().child("Cart")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        styling()
        print(item)
        // Do any additional setup after loading the view.
    }
    
    private func configure(){
        guard let url = URL(string: item.Photo!) else { return }
        itemImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .highPriority)
        titleLabel.text = item.Name
        priceLabel.text = ("Rs. ")+(item.Price!)
        quantityLabel.text = "1"
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
        Utility.styleFilledButton(addToCartButton)
        Utility.styleHollowButton(cancelButton)
        Utility.styleIncreaseButton(increaseButton)
        Utility.styleDecreaseButton(decreaseButton)
        priceLabel.textColor = .systemGreen
        
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
        }
        
    }
    
    
    @IBAction func increaseButtonTapped(_ sender: Any) {
        if Int(quantityLabel.text!)! < 100{
            let temp = Int(quantityLabel.text!)! + Int(1)
            quantityLabel.text = String(temp)
        }
    }
    
    
    @IBAction func addToCartTapped(_ sender: Any) {
        guard let stock = item.Stock else {return}
        if stock{
            sendToCart()
        }
        else{
            Utility.alert(title: "Out Of Stock", msg: "Sorry! The product is out of stock.", viewcontroller: self)
        }
    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
