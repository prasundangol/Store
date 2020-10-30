//
//  OrderTableViewCell.swift
//  Store
//
//  Created by MacBook Air on 10/23/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let identifier = "OrderTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(item: CartModel){
        titleLabel.text = item.Name
        priceLabel.text = ("Rs. ") + item.Price!
    }

}
