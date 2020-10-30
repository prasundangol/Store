//
//  MyOrdersViewController.swift
//  Store
//
//  Created by MacBook Air on 9/7/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import FirebaseAuth

class MyOrdersViewController: UIViewController {
    
    
   
    @IBOutlet weak var orderTableView: UITableView!
    
    lazy var noItemImage = UIImageView()
    lazy var noItemLabel = UILabel()
    let window = UIWindow(frame: UIScreen.main.bounds)
    var orderedDates = [String]()
    var sortedItems = [[CartModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Orders"
        navigationController?.navigationBar.tintColor = .systemGreen
        orderTableView.backgroundColor = .systemGray5
        guard let _ = Auth.auth().currentUser?.uid else{
            return
        }
        orderTableView.delegate = self
        orderTableView.dataSource = self
        labelSetUp()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Utility.checkIfUserIsLoggedIn(viewController: self)
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 4) {
            if self.sortedItems.count == 0{
                self.noItemLabel.isHidden = false
                self.noItemImage.isHidden = false
            }
        }
    }
    
    private func getData(){
        getDataFromOrders.shared.getData(title: { (title) in
            self.orderedDates = title
            DispatchQueue.main.async {
                self.orderTableView.reloadData()
            }
        }) { (data) in
            self.sortedItems = data
            DispatchQueue.main.async {
                self.noItemLabel.isHidden = true
                self.noItemImage.isHidden = true
                self.orderTableView.reloadData()
            }
        } 
    }
    
    private func labelSetUp(){
        orderTableView.addSubview(noItemImage)
        orderTableView.addSubview(noItemLabel)
        
        let width = orderTableView.frame.width / 2 - 40
        let labelWidth = orderTableView.frame.height / 2 - 430
        
        noItemImage.image = UIImage(named: "noOrders")
        noItemImage.frame = CGRect(x: (orderTableView.frame.width/2) - 150, y: (orderTableView.frame.size.width - width)/2, width: 300, height: 300)
        noItemLabel.text = "No Orders Yet"
        
        noItemLabel.frame = CGRect(x: 0,
                                   y: (orderTableView.frame.size.height - labelWidth)/2,
                                   width: orderTableView.frame.size.width,
                                   height: 50)
        noItemLabel.textColor = .systemGray
        noItemLabel.textAlignment = .center
        noItemLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 23.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Consatnts.orderToOrderDetail{
            let destVC = segue.destination as! OrderDetailViewController
            destVC.itemArray = sender as! [CartModel]
            
        }
    }
}

extension MyOrdersViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sortedItems[section].count >= 3{
            return 3
        }
        else{
            return sortedItems[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderTableView.dequeueReusableCell(withIdentifier: OrdersTableViewCell.identifier, for: indexPath) as! OrdersTableViewCell
        let item = sortedItems[indexPath.section][indexPath.row]
        cell.configure(item: item)
//        if indexPath.row == 4{
//            cell.dotDotDot()
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var supp = String()
        for index in 0...section{
            supp = orderedDates[index]
        }
        return supp
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let vw = UIView()
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        header.textLabel?.textAlignment = NSTextAlignment.left
        header.textLabel?.textColor = UIColor.black
        vw.backgroundColor = UIColor.white
        header.backgroundView = vw
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        vw.backgroundColor = .systemGray5
        let button = UIButton(frame: CGRect(x: 0, y: 1, width: vw.frame.size.width, height: 40))
        button.setTitle("View All", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.systemOrange, for: .normal)
        button.tag = section
        button.addTarget(self, action: #selector(viewAllTapped(sender: )), for: .touchUpInside)
        button.backgroundColor = UIColor.white
        vw.addSubview(button)
        
        return vw
        
        
    }
    
    @objc func viewAllTapped(sender: UIButton!){
        let buttonTag = sender.tag
        let sendingItems = sortedItems[buttonTag]
        performSegue(withIdentifier: Consatnts.orderToOrderDetail, sender: sendingItems)
    }

    
}

