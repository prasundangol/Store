//
//  SearchViewController.swift
//  Store
//
//  Created by MacBook Air on 10/7/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    lazy var noItemLabel = UILabel()
    
    var tag = Int()
    var item = String()
    var itemArray = [ItemModel]()
    var searchedArray = [ItemModel]()
    var titleArray = [NSString]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchTextField.delegate = self
        labelSetUp()
        searchTextField.notSelected()
        configureCell()
        setUpLayout()
        getData()
    }
    
    
    private func getData(){
        if tag == 1{
            searchTextField.placeholder = "Search in Store"
            for item in Consatnts.itemList{
                FirebaseOperation.shared.getData(of: item) { (data) in
                    self.itemArray.append(data)
                }
            }
        }
        else{
            searchTextField.placeholder = "Search in \(item)"
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
        
        searchCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    private func configureCell(){
        searchCollectionView.register(SearchCollectionViewCell.nib() , forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
    
    private func labelSetUp(){
        searchCollectionView.addSubview(noItemLabel)
        
        noItemLabel.text = "No Result"
        let width = searchCollectionView.frame.width / 2 - 50
        
        noItemLabel.frame = CGRect(x: 0,
                                   y: (searchCollectionView.frame.size.width - width)/2,
                                   width: searchCollectionView.frame.size.width,
                                   height: 50)
        noItemLabel.textColor = .systemGray2
        noItemLabel.textAlignment = .center
        noItemLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 23.0)
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchedArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        let item = searchedArray[indexPath.row]
        cell.configure(item: item)
        noItemLabel.isHidden = true
        Utility.stylingCollectionViewCell(cell: cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchCollectionView.deselectItem(at: indexPath, animated: true)
        let item = searchedArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        vc.item = item
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
}

extension SearchViewController: UITextFieldDelegate{
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        noItemLabel.isHidden = false
        searchedArray.removeAll()
        searchCollectionView.reloadData()
        return false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchTextField.text?.count != 0{
            self.searchedArray.removeAll()
            for str in itemArray{
                let range = str.Name!.lowercased().range(of: textField.text!, options: .caseInsensitive)
                if range != nil{
                    self.searchedArray.append(str)
                }
                
            }
        }
        searchCollectionView.reloadData()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextField.paddingLeft()
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.notSelected()
    }
    
}
