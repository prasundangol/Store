//
//  File.swift
//  Store
//
//  Created by MacBook Air on 9/8/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import Foundation
import FirebaseFirestore


struct ItemModel {
    var Name: String?
    var ProductId: String?
    var Photo: String?
    var Price: String?
    
    

}

class FirebaseOperation{
    
    //private init(){}
    
    static let shared = FirebaseOperation()
     var itemArray = [ItemModel]()
    
   
    
    func getData(of item: [String], completion: @escaping (([ItemModel]) -> ())){
        DispatchQueue.global(qos: .userInteractive).async {
            let db = Firestore.firestore()
                
                db.collection("Fruits").addSnapshotListener { (snapshot, error) in
                    guard let snapshot = snapshot else {return}
                    for document in snapshot.documents{
                        //print(document.data())
                        let itemObject = document.data()
                        let name = itemObject["Name"] as! String
                        let price = itemObject["Price"] as! String
                        let photo = itemObject["Photo"] as! String
                        let data = ItemModel(Name: name, Photo: photo, Price: price)
                        self.itemArray.append(data)
                        //print(self.itemArray)
                       //print(price)
                            completion(self.itemArray)

                    }
                }
        }

            
        
        
   }
}



