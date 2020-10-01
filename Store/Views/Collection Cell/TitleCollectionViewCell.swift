//
//  TitleCollectionViewCell.swift
//  Store
//
//  Created by MacBook Air on 9/7/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "TitleCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        titleImage.layer.borderWidth = 1
        titleImage.layer.borderColor = UIColor.systemGray.cgColor
        titleImage.clipsToBounds = true
        titleImage.layer.cornerRadius = 10
    }
    
    static func nib() -> UINib{
        
        return UINib(nibName: "TitleCollectionViewCell", bundle: nil)
    }
    
    public func configure(with titles: String){
        self.titleLabel.text = titles
        self.titleImage.image = UIImage(named: titles)
    }

}


