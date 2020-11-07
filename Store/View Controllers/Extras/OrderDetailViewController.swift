//
//  OrderDetailViewController.swift
//  Store
//
//  Created by MacBook Air on 10/28/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController {
    
    
    @IBOutlet weak var orderDetailTableView: UITableView!
    @IBOutlet weak var totalMrpLabel: UILabel!
    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    
    var itemArray = [CartModel]()
    var mrpPrice = Int()
    var vat = Int()
    var totalPrice = Int()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Order Detail"
        orderDetailTableView.delegate = self
        orderDetailTableView.dataSource = self
        priceCalculations()
        configure()
    }
    
     private func priceCalculations(){
        for price in itemArray{
            mrpPrice = mrpPrice + Int(price.Price!)!
        }
           vat = Int(0.13 * Double((mrpPrice)))
           totalPrice = vat + mrpPrice
       }
    
    private func configure(){
        totalMrpLabel.text = "Rs. " + String(mrpPrice)
        vatLabel.text = "Rs. " + String(vat)
        totalPriceLabel.text = "Rs. " + String(totalPrice)
        for item in itemArray{
            paymentLabel.text = item.payment
        }
    }

}

extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderDetailTableView.dequeueReusableCell(withIdentifier: OrderDetailCell.identifier, for: indexPath) as! OrderDetailCell
        cell.configure(item: itemArray[indexPath.row])
        return cell
    }
    
    
}
