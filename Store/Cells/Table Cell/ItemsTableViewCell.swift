//
//  ItemsTableViewCell.swift
//  Store
//
//  Created by MacBook Air on 9/8/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import FirebaseFirestore

protocol ItemsTableViewCellDelegate: AnyObject {
    func didSelectCollectionItem(with item: ItemModel)
}

class ItemsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var itemCollectionView: UICollectionView!
    
    
    static let identifier = "ItemsTableViewCell"
    var firstItemArray: [ItemModel] = []
    var secondItemArray: [ItemModel] = []
    var totalItems: [[ItemModel]] = []
    var titles = ["Fruits"]
    public weak var delegate: ItemsTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemCollectionView.register(ItemsCollectionViewCell.nib(), forCellWithReuseIdentifier: ItemsCollectionViewCell.identifier)
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        listCellStyle()
        itemCollectionView.showsHorizontalScrollIndicator = false
        itemCollectionView.reloadData()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "ItemsTableViewCell", bundle: nil)
        
    }
    
    private func listCellStyle(){
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 280 , height: 180)
        layout.sectionInset = UIEdgeInsets.zero
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        self.itemCollectionView.collectionViewLayout = layout
    }
    
    public func configureFirstSection(item: String){
        FirebaseOperation.shared.getData(of: item) { (data) in
            self.totalItems.removeAll()
            self.firstItemArray.append(data)
            self.totalItems.append(self.firstItemArray)
            DispatchQueue.main.async {
                self.itemCollectionView.reloadData()
            }
        }
    }
        public func configureSecondSection(item: String){
            FirebaseOperation.shared.getData(of: item) { (data) in
                self.totalItems.removeAll()
                self.secondItemArray.append(data)
                self.totalItems.append(self.secondItemArray)
                DispatchQueue.main.async {
                    self.itemCollectionView.reloadData()
                }
            }


    }
}

extension ItemsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return totalItems.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: ItemsCollectionViewCell.identifier, for: indexPath) as! ItemsCollectionViewCell
        let item = self.totalItems[indexPath.section][indexPath.item]
        cell.configure(item: item)
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 30
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = totalItems[indexPath.section][indexPath.row]
        delegate?.didSelectCollectionItem(with: item)
    }
    
}
