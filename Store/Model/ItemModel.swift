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
    var Stock: Bool?
}

class FirebaseOperation{
    
    let db = Firestore.firestore()
    static let shared = FirebaseOperation()    
   
    
    func getData(of item: String, completion: @escaping ((ItemModel) -> ())){
        DispatchQueue.global(qos: .userInteractive).async {
                
            self.db.collection(item).getDocuments { (snapshot, error) in
                    guard let snapshot = snapshot else {return}
                    for document in snapshot.documents{
                        let itemObject = document.data()
                        let name = itemObject["Name"] as! String
                        let price = itemObject["Price"] as! String
                        let photo = itemObject["Photo"] as! String
                        let productId = itemObject["ProductId"] as! String
                        let stock = itemObject["Stock"] as! Bool
                        
                        let data = ItemModel(Name: name, ProductId: productId, Photo: photo, Price: price, Stock: stock)
                            completion(data)

                    }
                    

                }
        }

            
        
        
   }
}
