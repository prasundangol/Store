//
//  CartModel.swift
//  Store
//
//  Created by MacBook Air on 9/21/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct CartModel {
    var Name: String?
    var ProductId: String?
    var Photo: String?
    var Price: String?
    var Quantity: String
}

class getDataFromCart{
    let ref = Database.database().reference().child("Cart")
    let uid = Auth.auth().currentUser?.uid
    var itemList = [CartModel]()
    static let shared = getDataFromCart()
    
    
    func getData(completion: @escaping (([CartModel]) -> ())){
        guard let user = uid else {
            return
        }
        ref.child(user).observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0{
                self.itemList.removeAll()
                for items in snapshot.children.allObjects as![DataSnapshot]{
                    let itemObject = items.value as? [String: Any]
                    let name = itemObject?["Name"] as! String
                    let price = itemObject?["Price"] as! String
                    let photo = itemObject?["Photo"] as! String
                    let productId = itemObject?["ProductId"] as! String
                    let quantity = itemObject?["Quantity"] as! String
                    let item = CartModel(Name: name, ProductId: productId, Photo: photo, Price: price, Quantity: quantity)
                    self.itemList.append(item)
                    completion(self.itemList)
                }
                
            }
        }
    }
    
}
