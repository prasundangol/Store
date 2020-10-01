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
    lazy var noItemLabel = UILabel()
    let vw = UIView()
    lazy var refreshControl = UIRefreshControl()
    
    private var cartItems = [CartModel]()
    private let ref = Database.database().reference().child("Cart")
    private var totalPrice = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cart"
        cartTableView.separatorStyle = .none
        cartTableView.backgroundColor = UIColor.systemGray6
        guard let _ = Auth.auth().currentUser?.uid else{
            return
        }
        activityIndicator.startAnimating()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        getData()
        labelSetUp()
        refreshTable()
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Utility.checkIfUserIsLoggedIn(viewController: self)
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 4) {
            if self.cartItems.count == 0{
                self.noItemLabel.isHidden = false
                self.activityIndicator.stopAnimating()
                self.vw.isHidden = true
            }
        }
    }
    
    private func refreshTable(){
        refreshControl.attributedTitle = NSAttributedString(string: "Reload")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        cartTableView.refreshControl = refreshControl
    }
    
    @objc func refresh() {
       // Code to refresh table view
        self.getData()
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
        
    }
    
    private func labelSetUp(){
        cartTableView.addSubview(noItemLabel)
        
        noItemLabel.text = "No Items Available"
        let width = cartTableView.frame.width / 2 - 50
        
        noItemLabel.frame = CGRect(x: 0,
                                   y: (cartTableView.frame.size.width - width)/2,
                                   width: cartTableView.frame.size.width,
                                   height: 50)
        noItemLabel.textColor = .systemGray2
        noItemLabel.textAlignment = .center
        noItemLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 23.0)
    }
    
    private func getData(){
        getDataFromCart.shared.getData { [weak self] (data) in
            guard let self = self else {return}
            self.cartItems = data
            DispatchQueue.main.async {
                self.vw.isHidden = false
                self.noItemLabel.isHidden = true
                self.activityIndicator.stopAnimating()
                self.cartfooterView()
                self.cartTableView.reloadData()
            }
        }
    }
    
    private func cartfooterView(){
        
        vw.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 70)
        vw.backgroundColor = UIColor.systemGray6
        cartTableView.tableFooterView = vw
        
        let button = UIButton()
        vw.addSubview(button)
        var viewWidth: CGFloat{
            return vw.frame.size.width
        }
        
        let width = vw.frame.size.width - 40
        let height = vw.frame.size.height - 20
        
        button.frame = CGRect(x: (vw.frame.size.width - width)/2 ,
                              y: (vw.frame.size.height - height)/2 ,
                              width: width,
                              height: height)
        for price in cartItems{
            totalPrice = totalPrice + Int(price.Price!)!
        }
        
        button.setTitle("Checkout: Rs. \(String(totalPrice))", for: .normal)
        button.setTitleColor(Consatnts.darkColor, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18.0)
        totalPrice = 0

        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.buttonStyling()
        button.addTarget(self, action: #selector(didTapCheckout), for: .touchUpInside)

        
    }
    
    @objc func didTapCheckout(){
        performSegue(withIdentifier: Consatnts.cartToCheckoutSegue , sender: cartItems)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Consatnts.cartToCheckoutSegue{
            let destVC = segue.destination as! CheckoutViewController
            destVC.checkOutItems = sender as! [CartModel]
            
        }
    }
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
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
            
            if cartItems.count == 0{
                DispatchQueue.main.async {
                    self.vw.isHidden = true
                    self.noItemLabel.isHidden = false
                }
            }
            
        }
    }
    
    
}
    
