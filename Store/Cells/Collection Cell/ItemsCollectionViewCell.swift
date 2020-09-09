//
//  ItemsCollectionViewCell.swift
//  Store
//
//  Created by MacBook Air on 9/8/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class ItemsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let identifier = "ItemsCollectionViewCell"
    private var item = ItemModel()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    
    static func nib() -> UINib{
        return UINib(nibName: "ItemsCollectionViewCell", bundle: nil)
        
    }
    
    public func configure(){
        itemImage.image = UIImage(named: "orange")
        itemNameLabel.text = "Orange"
        priceLabel.text = "Rs. 190"
    }

}
