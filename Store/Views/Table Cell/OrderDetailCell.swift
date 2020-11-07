//
//  OrderDetailCell.swift
//  Store
//
//  Created by MacBook Air on 11/2/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class OrderDetailCell: UITableViewCell {
    
    
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    static let identifier = "OrderDetailCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(item: CartModel){
        itemTitle.text = item.Name! + " x " + item.Quantity!
        itemPrice.text = "Rs. " + item.Price!
    }

}
