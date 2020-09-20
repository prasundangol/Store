//
//  ViewController.swift
//  Store
//
//  Created by MacBook Air on 9/12/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var listCollectionView: UICollectionView!
    
    static let identifier = "ListViewController"
    private var model: [ItemModel] = []
    var listTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        self.title = listTitle
        configureCell()
        setUpLayout()
        listCollectionView.showsVerticalScrollIndicator = false
        FirebaseOperation.shared.getData(of: listTitle) { (data) in
            self.model.append(data)
            self.listCollectionView.reloadData()
        }
        // Do any additional setup after loading the view.
        self.listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        self.listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    private func configureCell(){
        listCollectionView.register(ListCollectionViewCell.nib() , forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        
    }
    
    private func setUpLayout(){
        let layout = UICollectionViewFlowLayout()
        let itemsInRow: CGFloat = 2
        let lineSpacing: CGFloat = 10
        let interItemSpacing: CGFloat = 10
        
        let width = (listCollectionView.frame.size.width-(itemsInRow - 1) * interItemSpacing) / itemsInRow
        let height = width + 20
        
        layout.itemSize = CGSize(width: width - 10, height: height)
        layout.sectionInset = .zero
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interItemSpacing
        
        listCollectionView.setCollectionViewLayout(layout, animated: true)
        
        
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Consatnts.listToDetailSegue{
            let destVC = segue.destination as! DetailViewController
            destVC.item = sender as! ItemModel
        }
    }

}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = listCollectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as! ListCollectionViewCell
        cell.setUp(items: model[indexPath.item])
       cell.layer.masksToBounds = true
       cell.layer.cornerRadius = 30
       cell.layer.borderColor = UIColor.gray.cgColor
       cell.layer.borderWidth = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = model[indexPath.row]
        performSegue(withIdentifier: Consatnts.listToDetailSegue, sender: item)
    }
    
}
