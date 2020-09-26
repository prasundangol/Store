//
//  CartViewController.swift
//  Store
//
//  Created by MacBook Air on 9/7/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CartViewController: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    lazy var noItemLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
    
    private var cartItems = [CartModel]()
    private let ref = Database.database().reference().child("Cart")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cart"
        cartTableView.separatorStyle = .none
        guard let _ = Auth.auth().currentUser?.uid else{
            return
        }
        activityIndicator.startAnimating()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        getData()
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Utility.checkIfUserIsLoggedIn(viewController: self)
        
    }
    
    
    private func getData(){
        getDataFromCart.shared.getData { (data) in
            self.cartItems = data
            DispatchQueue.main.async {
                self.cartTableView.reloadData()
            }
        }
    }
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        let item = cartItems[indexPath.row]
        cell.configure(item: item)
        cartTableView.separatorStyle = .singleLine
        self.activityIndicator.stopAnimating()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cartTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete){
            let item = cartItems[indexPath.row]
            let user = Auth.auth().currentUser?.uid
            //Removing data from databse
            ref.child(user!).child(item.Name!).removeValue()
            
            //Removing data from array
            cartTableView.beginUpdates()
            cartItems.remove(at: indexPath.row)
            cartTableView.deleteRows(at: [indexPath], with: .right)
            cartTableView.endUpdates()
            
        }
    }
    
    
}
    
