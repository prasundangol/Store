//
//  CheckoutViewController.swift
//  Store
//
//  Created by MacBook Air on 10/1/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    var checkOutItems = [CartModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Checkout"
        print(checkOutItems.count)
        // Do any additional setup after loading the view.
    }

}
