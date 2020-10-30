//
//  SearchCollectionViewCell.swift
//  Store
//
//  Created by MacBook Air on 10/7/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let identifier = "SearchCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        
    }
    
    public func configure(item: ItemModel){
        let url = URL(string: item.Photo!)
        itemImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .highPriority)
        titleLabel.text = item.Name
        priceLabel.text = ("Rs. ") + (item.Price!)
        
    }

}
