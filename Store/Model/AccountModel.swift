//
//  AccountModek.swift
//  Store
//
//  Created by MacBook Air on 11/3/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct AccountModel {
    var fName: String?
    var lName: String?
    var location: String?
    var phno: String?
    
}

class getAccountInfo{
    let db = Firestore.firestore()
    static let shared = getAccountInfo()
    
    func getData(completion: @escaping (AccountModel) -> ()){
        let uid = Auth.auth().currentUser?.uid
        
        guard let user = uid else{return}
        
        self.db.collection("users").whereField("uid", isEqualTo: user).getDocuments { (snapshot, error) in
            if let _ = error{
                print("Error")
            }
            guard let snapshot = snapshot else {return}
            for document in snapshot.documents{
                let itemObject = document.data()
                let fname = itemObject["firstname"] as! String
                let lname = itemObject["lastname"] as! String
                let location = itemObject["location"] as! String
                let phno = itemObject["phno"] as! String
                let item = AccountModel(fName: fname, lName: lname, location: location, phno: phno)
                completion(item)
                
            }
        }
        
    }
}
