//
//  AccountViewController.swift
//  Store
//
//  Created by MacBook Air on 9/7/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Account"
        Utility.checkIfUserIsLoggedIn(viewController: self)
    }
    

}
