//
//  ListTableViewCell.swift
//  Store
//
//  Created by MacBook Air on 9/16/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    static let identifier = "ListTableViewCell"

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private var models = [ItemModel]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        priceLabel.textColor = .systemGreen
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "ListTableViewCell", bundle: nil)
        
    }
    
    public func configure(with models: ItemModel){
        guard let url = URL(string: models.Photo!) else { return }
        itemImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: .highPriority)
        nameLabel.text = models.Name
        priceLabel.text = ("Rs. ") + (models.Price!)
    }
    
}
