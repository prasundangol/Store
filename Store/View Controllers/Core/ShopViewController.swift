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
    private var models: [ItemModel] = []
       private let titles = ["Fruits", "Vegtables"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shop"
        titleTable.delegate = self
        titleTable.dataSource = self
        configureCell()
        
    }
    
    private func configureCell(){
        titleTable.register(TitleTableViewCell.nib(), forCellReuseIdentifier: TitleTableViewCell.identifier)
        titleTable.register(ItemsTableViewCell.nib(), forCellReuseIdentifier: ItemsTableViewCell.identifier)
        
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
            
            return cell
        }
        else{
            let cell =  titleTable.dequeueReusableCell(withIdentifier: ItemsTableViewCell.identifier, for: indexPath) as! ItemsTableViewCell
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section > 0{
            return "This is a header"
        }
        return ""
    }
    
    
}


