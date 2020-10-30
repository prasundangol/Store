//
//  OrderModel.swift
//  Store
//
//  Created by MacBook Air on 10/9/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class getDataFromOrders{
    let ref = Database.database().reference().child("orders")
    var itemList = [CartModel]()
    static let shared = getDataFromOrders()
    var totalList = [[CartModel]]()
    var keys = [String]()
    
//    func getOrderedDate(completion: @escaping (([String]) -> ())){
//        let uid = Auth.auth().currentUser?.uid
//        guard let user = uid else {
//            return
//        }
//        ref.child(user).observe(.value) { (snap) in
//            self.keys.removeAll()
//            for child in snap.children{
//                let data = child as! DataSnapshot
//                self.keys.append(data.key)
//                completion(self.keys)
//            }
//        }
//    }
    
    func getData(title: @escaping (([String])) -> (),completion: @escaping (([[CartModel]]) -> ())){
        let uid = Auth.auth().currentUser?.uid
        guard let user = uid else {
            return
        }
        //Getting the data
        ref.child(user).queryOrdered(byChild: "data/timestamp").observe(.value) { (snap) in
            self.keys.removeAll()
            for child in snap.children{
                let data = child as! DataSnapshot
                self.keys.append(data.key)
                self.totalList.removeAll()
                self.ref.child(user).child(data.key).child("data").observe(.value) { (snapshot) in
                    self.itemList.removeAll()
                    for items in snapshot.children.allObjects as![DataSnapshot]{
                        if items.key == "timestamp"{
                            print("HEHEHE")
                        }
                        else{
                        let itemObject = items.value as? [String: Any]
                        let name = itemObject?["Name"] as! String
                        let price = itemObject?["Price"] as! String
                        let productId = itemObject?["ProductId"] as! String
                        let quantity = itemObject?["Quantity"] as! String
                        let item = CartModel(Name: name, ProductId: productId, Price: price, Quantity: quantity)
                        self.itemList.append(item)
                        }
                    }
                    self.totalList.append(self.itemList)
                    title(self.keys)
                    completion(self.totalList)
                }
            
            }
        }
        
    }
    
    
}






