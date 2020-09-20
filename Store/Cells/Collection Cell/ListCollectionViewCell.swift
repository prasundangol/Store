//
//  ListCollectionViewCell.swift
//  Store
//
//  Created by MacBook Air on 9/12/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import SDWebImage

class ListCollectionViewCell: UICollectionViewCell {

    static let identifier = "ListCollectionViewCell"
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        priceLabel.textColor = .systemGreen
        // Initialization code
    }

    static func nib() -> UINib{
        return UINib(nibName: "ListCollectionViewCell", bundle: nil)
        
    }
    
    public func setUp(items: ItemModel){
        let url = URL(string: items.Photo!)
        itemImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .highPriority)
        titleLabel.text = items.Name
        priceLabel.text = ("Rs. ") + (items.Price!)
    }
}
