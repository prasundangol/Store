//
//  ViewController.swift
//  Store
//
//  Created by MacBook Air on 9/7/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {
    
    @IBOutlet weak var titleTable: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    static let identifier = "ShopViewController"
    private let itemController = ItemsTableViewCell()
    private var itemModels = [ItemModel]()
    private let titles = ["Fruits", "Vegtables", "Drinks", "Snacks","Dairy", "Grocery"]
    var resultSet = Set<String>()
    var resultArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shop"
        getRandomElements()
        activityIndicator.startAnimating()
        navigationController?.navigationBar.tintColor = UIColor.systemGreen
        titleTable.delegate = self
        titleTable.dataSource = self
        getData()
        configureCell()
        titleTable.showsVerticalScrollIndicator = false
    }
    
    private func getData(){
        FirebaseOperation.shared.getData(of: resultArray[2]) { [weak self] (data) in
            guard let self = self else {return}
            //self.itemModels.removeAll()
            self.itemModels.append(data)
            DispatchQueue.main.async {
                self.titleTable.reloadData()
            }
        }
    }
    
    private func configureCell(){
        titleTable.register(TitleTableViewCell.nib(), forCellReuseIdentifier: TitleTableViewCell.identifier)
        titleTable.register(ItemsTableViewCell.nib(), forCellReuseIdentifier: ItemsTableViewCell.identifier)
        titleTable.register(HeaderTableViewCell.nib(), forCellReuseIdentifier: HeaderTableViewCell.identifier)
        titleTable.register(ListTableViewCell.nib(), forCellReuseIdentifier: ListTableViewCell.identifier)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Consatnts.shopToDetailSegue{
            let destVC = segue.destination as! DetailViewController
            destVC.item = sender as! ItemModel
            
        }
        
        if segue.identifier == Consatnts.shopToSearchSegue{
            let destVC = segue.destination as! SearchViewController
            destVC.tag = 1
        }
    }
    
    private func getRandomElements(){
        while resultSet.count < 3 {
            let randomIndex = Int(arc4random_uniform(UInt32(titles.count)))
            resultSet.insert(titles[randomIndex])
        }
         resultArray = Array(resultSet)
    }
    
    @IBAction func didTapSearch(_ sender: Any) {
        performSegue(withIdentifier: Consatnts.shopToSearchSegue, sender: nil)
    }
    
}

extension ShopViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3{
            return itemModels.prefix(4).count
        }
        else{
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = titleTable.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
            cell.delegate = self
            return cell
        }
        switch indexPath.section {
        case 1 :
            let cell =  titleTable.dequeueReusableCell(withIdentifier: ItemsTableViewCell.identifier, for: indexPath) as! ItemsTableViewCell
            cell.configureFirstSection(item: resultArray[0])
            cell.delegate = self
            return cell
        case 2:
            let cell =  titleTable.dequeueReusableCell(withIdentifier: ItemsTableViewCell.identifier, for: indexPath) as! ItemsTableViewCell
            cell.configureFirstSection(item: resultArray[1])
            cell.delegate = self
            return cell
            
        case 3:
            let bottomCell = titleTable.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as! ListTableViewCell
            let item = itemModels[indexPath.item]
            bottomCell.configure(with: item)
            self.activityIndicator.stopAnimating()
            return bottomCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section > 0{
            return 230
        }
        return 220
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = titleTable.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
        cell.configure(item: resultArray[section - 1])
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0{
            return 40
        }
        return 0
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.section == 3{
                titleTable.deselectRow(at: indexPath, animated: true)
                let items = itemModels[indexPath.row]
                performSegue(withIdentifier: Consatnts.shopToDetailSegue, sender: items)
            }
        }
    
}

extension ShopViewController: TitleTableViewCellDelegate{
    func didSelectItem(with title: String) {
        let vc = storyboard?.instantiateViewController(identifier: ListViewController.identifier) as! ListViewController
        vc.listTitle = title
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension ShopViewController: HeaderTableViewCellDelegate{
    func didTapButton(item: String) {
        let vc = storyboard?.instantiateViewController(identifier: ListViewController.identifier) as! ListViewController
        vc.listTitle = item
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension ShopViewController: ItemsTableViewCellDelegate{
    func didSelectCollectionItem(with item: ItemModel) {
        performSegue(withIdentifier: Consatnts.shopToDetailSegue, sender: item)
    }
}


