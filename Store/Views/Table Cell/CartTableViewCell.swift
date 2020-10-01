//
//  CartTableViewCell.swift
//  Store
//
//  Created by MacBook Air on 9/21/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    static let identifier = "CartTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        quantityLabel.textColor = .systemGray
        priceLabel.textColor = .systemGreen
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(item: CartModel){
        let url = URL(string: item.Photo!)
        itemImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .highPriority)
        itemLabel.text = item.Name
        quantityLabel.text = "Quantity: " + (item.Quantity)
        priceLabel.text = "Rs. " + (item.Price!)
        
    }

}
