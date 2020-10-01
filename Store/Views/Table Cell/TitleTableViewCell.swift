//
//  TitleTableViewCell.swift
//  Store
//
//  Created by MacBook Air on 9/7/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

protocol TitleTableViewCellDelegate: AnyObject {
    func didSelectItem(with title: String )
}

class TitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleCollectionView: UICollectionView!
    
    static let identifier = "TitleTableViewCell"
    public weak var delegate: TitleTableViewCellDelegate?
    
    private let titles = ["Fruits", "Vegtables", "Drinks", "Snacks", "Dairy", "Grocery"]
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var navigationController = UINavigationController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleCollectionView.delegate = self
        titleCollectionView.dataSource = self
        titleCollectionView.register(TitleCollectionViewCell.nib(), forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        setUpLayout()
        titleCollectionView.showsVerticalScrollIndicator = false
        titleCollectionView.isScrollEnabled = false

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "TitleTableViewCell", bundle: nil)
    }
    
    private func setUpLayout(){
        let layout = UICollectionViewFlowLayout()
        let itemsInRow: CGFloat = 3
        let lineSpacing: CGFloat = 5
        let interItemSpacing: CGFloat = 5
        
        let width = (titleCollectionView.frame.size.width-(itemsInRow - 1) * interItemSpacing) / itemsInRow
        let height = width 
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interItemSpacing
        
        titleCollectionView.setCollectionViewLayout(layout, animated: true)
        
        
    }
    
    
    
}

extension TitleTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = titleCollectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as! TitleCollectionViewCell
        cell.configure(with: titles[indexPath.row])
        
//        cell.layer.masksToBounds = false
//        cell.clipsToBounds = false
//        cell.backgroundColor = .systemBackground
//        cell.layer.cornerRadius = 15
//        cell.layer.shadowOffset = CGSize(width: 3, height: 4)
//        cell.layer.shadowRadius = 3
//        cell.layer.shadowColor = UIColor.darkGray.cgColor
//        cell.layer.shadowOpacity = 0.5
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item: String
        item = titles[indexPath.row]       
        delegate?.didSelectItem(with: item)
    }
    
}
