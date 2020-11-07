//
//  HeaderTableViewCell.swift
//  Store
//
//  Created by MacBook Air on 9/12/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

protocol HeaderTableViewCellDelegate: AnyObject {
    func didTapButton(item: String)
}

class HeaderTableViewCell: UITableViewCell {
    
    static let identifier = "HeaderTableViewCell"
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var viewAllButton: UIButton!
    
    private var item = String()
    weak var delegate: HeaderTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .systemBackground
        viewAllButton.underline()
        viewAllButton.layer.masksToBounds = false
        viewAllButton.clipsToBounds = false
        viewAllButton.layer.shadowOpacity = 0.3
        viewAllButton.layer.shadowRadius = 3
        viewAllButton.layer.shadowOffset = CGSize(width: 3, height: 4)
        viewAllButton.layer.shadowColor = UIColor.systemOrange.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "HeaderTableViewCell", bundle: nil)
        
    }
    
    public func configure(item: String){
        self.item = item
        headerLabel.text = self.item
    }
    
    @IBAction func didTapViewAll(_ sender: Any) {
        delegate?.didTapButton(item: item)
    }
    
    
}
