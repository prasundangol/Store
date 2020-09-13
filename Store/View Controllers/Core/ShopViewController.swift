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
    private var models = [ItemModel]()
    var sectionItems = [String]()
    private let titles = ["Fruits", "Vegtables", "Drinks"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shop"
        titleTable.delegate = self
        titleTable.dataSource = self
        configureCell()
        titleTable.showsVerticalScrollIndicator = false
        for _ in 1...2{
            sectionItems.append(titles.randomElement()!)
        }
    }
    
    private func configureCell(){
        titleTable.register(TitleTableViewCell.nib(), forCellReuseIdentifier: TitleTableViewCell.identifier)
        titleTable.register(ItemsTableViewCell.nib(), forCellReuseIdentifier: ItemsTableViewCell.identifier)
        titleTable.register(HeaderTableViewCell.nib(), forCellReuseIdentifier: HeaderTableViewCell.identifier)
    
    }
    



}

extension ShopViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = titleTable.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
            cell.delegate = self
            return cell
        }
//        if indexPath.section%2 != 0 {
//            let cell = titleTable.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
//            if indexPath.section == 1{
//                cell.configure(item: titles[0])
//            }
//            if indexPath.section == 3{
//                cell.configure(item: titles[1])
//            }
//            if indexPath.section == 5{
//                cell.configure(item: titles[2])
//            }
//            cell.delegate = self
//            return cell
//        }
        if indexPath.section != 0{
            let cell =  titleTable.dequeueReusableCell(withIdentifier: ItemsTableViewCell.identifier, for: indexPath) as! ItemsTableViewCell
            if indexPath.section == 1{
                cell.configureFirstSection(item: titles[0])
            }
            if indexPath.section == 2{
                cell.configureSecondSection(item: titles[1])
            }
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = titleTable.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
        cell.configure(item: titles[section - 1])
        cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0{
            return 40
        }
        return 0
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


