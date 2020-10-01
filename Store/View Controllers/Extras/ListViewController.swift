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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    static let identifier = "ListViewController"
    private var model: [ItemModel] = []
    var listTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        self.title = listTitle
        configureCell()
        setUpLayout()
        listCollectionView.showsVerticalScrollIndicator = false
        getData()
    }
    
    private func configureCell(){
        listCollectionView.register(ListCollectionViewCell.nib() , forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        
    }
    
    private func getData(){
        FirebaseOperation.shared.getData(of: listTitle) { [weak self] (data) in
            guard let self = self else {return}
            self.model.append(data)
            self.listCollectionView.reloadData()
        }
    }
    
    private func setUpLayout(){
        let layout = UICollectionViewFlowLayout()
        let itemsInRow: CGFloat = 2
        let lineSpacing: CGFloat = 10
        let interItemSpacing: CGFloat = 10
        
        let width = (UIScreen.main.bounds.width-(itemsInRow - 1) * interItemSpacing) / itemsInRow
        let height = width 
        
        layout.itemSize = CGSize(width: width - 20, height: height)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
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
       
        self.activityIndicator.stopAnimating()
        Utility.stylingCollectionViewCell(cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = model[indexPath.row]
        performSegue(withIdentifier: Consatnts.listToDetailSegue, sender: item)
    }
    
}
