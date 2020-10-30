//
//  OrdersTableViewCell.swift
//  Store
//
//  Created by MacBook Air on 10/23/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let identifier = "OrdersTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(item: CartModel){
        itemImage.image = UIImage(named: "item")
        titleLabel.text = item.Name ?? ""
        priceLabel.text = "Rs. " + item.Price!
    }
    
    public func dotDotDot(){
        itemImage.image = UIImage(named: "item")
        titleLabel.text = "..."
        priceLabel.text = ""
    }

}
