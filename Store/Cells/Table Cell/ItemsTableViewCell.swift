//
//  ItemsTableViewCell.swift
//  Store
//
//  Created by MacBook Air on 9/8/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ItemsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var itemCollectionView: UICollectionView!
    
    static let identifier = "ItemsTableViewCell"
    var itemArray = [ItemModel]()
    let titles = ["Fruits", "Vegtables"]

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemCollectionView.register(ItemsCollectionViewCell.nib(), forCellWithReuseIdentifier: ItemsCollectionViewCell.identifier)
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        listCellStyle()
        FirebaseOperation.shared.getData(of: titles) { (data) in
            self.itemArray = data
            print(self.itemArray)
            print("step 2")
            
        }


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
        layout.itemSize = CGSize(width: 280 , height: 200)
        layout.sectionInset = UIEdgeInsets.zero
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        self.itemCollectionView.collectionViewLayout = layout
    }
    
    
}

extension ItemsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: ItemsCollectionViewCell.identifier, for: indexPath) as! ItemsCollectionViewCell
       // let item: ItemModel
        let item = itemArray.count
        print("Total Items: \(item)")
        
            cell.configure()
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 30
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    
    
}
