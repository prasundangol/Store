//
//  Utility.swift
//  Store
//
//  Created by MacBook Air on 9/12/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import Foundation
import UIKit

class Utility{
    static func alert(title: String, msg: String, viewcontroller: UIViewController){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil ))
        viewcontroller.present(alert, animated: true)
        
        
    }
}
