//
//  BottomTableViewCell.swift
//  Store
//
//  Created by MacBook Air on 9/13/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import SDWebImage

class BottomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let identifier = "BottomTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib{
        
        return UINib(nibName: "BottomTableViewCell", bundle: nil)
    }
    
    public func configure(item: ItemModel){
        guard let url = URL(string: item.Photo!) else { return }
        itemImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .highPriority)
        titleLabel.text = item.Name
        priceLabel.text = item.Price
    }
    
}
