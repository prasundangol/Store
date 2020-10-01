//
//  ItemsCollectionViewCell.swift
//  Store
//
//  Created by MacBook Air on 9/8/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import SDWebImage

class ItemsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!    
    
    static let identifier = "ItemsCollectionViewCell"
    private var item = ItemModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        priceLabel.textColor = .systemGreen
    }
    
    
    static func nib() -> UINib{
        return UINib(nibName: "ItemsCollectionViewCell", bundle: nil)
        
    }
    
    public func configure(item: ItemModel){
        guard let url = URL(string: item.Photo!) else { return }
        itemImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .highPriority)
        itemNameLabel.text = item.Name
        priceLabel.text = ("Rs. ")+(item.Price!)
    }

}
