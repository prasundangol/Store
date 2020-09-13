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
        self.backgroundColor = .white
        viewAllButton.layer.masksToBounds = true
        viewAllButton.layer.cornerRadius = 10
        viewAllButton.layer.borderColor = UIColor.gray.cgColor
        viewAllButton.layer.borderWidth = 1
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
