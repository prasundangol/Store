//
//  AccountViewController.swift
//  Store
//
//  Created by MacBook Air on 9/7/20.
//  Copyright © 2020 MacBook Air. All rights reserved.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {
    
    
    @IBOutlet weak var styleView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phnoLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var editProfile: UIButton!
    @IBOutlet weak var changePassword: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let user = Auth.auth().currentUser
    var Info = AccountModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Account"
        guard let _ = user?.uid else{return}
        activityIndicator.hidesWhenStopped = true
        styling()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Utility.checkIfUserIsLoggedIn(viewController: self)
        activityIndicator.startAnimating()
        getAccountData()
        
    }
    
    private func styling(){
        //Styling the view
        styleView.clipsToBounds = true
        styleView.layer.cornerRadius = 20
        styleView.backgroundGradient()
        
        //Styling the Profile Image
        profileImage.clipsToBounds = false
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.borderWidth = 2
        profileImage.layer.cornerRadius = 20
        profileImage.layer.opacity = 0.85
        
        //Editing Buttons
        editProfile.contentHorizontalAlignment = .left
        editProfile.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        editProfile.backgroundColor = .white
        editProfile.clipsToBounds = false
        editProfile.layer.masksToBounds = false
        editProfile.layer.borderColor = UIColor.systemGreen.cgColor
        editProfile.layer.borderWidth = 2
        editProfile.layer.cornerRadius = 10
        editProfile.layer.shadowColor = UIColor.systemGray.cgColor
        editProfile.layer.shadowOpacity = 0.5
        editProfile.layer.shadowOffset = CGSize(width: 2, height: 3)
        editProfile.layer.shadowRadius = 5
        
        changePassword.contentHorizontalAlignment = .left
        changePassword.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        changePassword.backgroundColor = .white
        changePassword.clipsToBounds = false
        changePassword.layer.masksToBounds = false
        changePassword.layer.borderColor = UIColor.systemGreen.cgColor
        changePassword.layer.borderWidth = 2
        changePassword.layer.cornerRadius = 10
        changePassword.layer.shadowColor = UIColor.systemGray.cgColor
        changePassword.layer.shadowOpacity = 0.5
        changePassword.layer.shadowOffset = CGSize(width: 2, height: 3)
        changePassword.layer.shadowRadius = 5
        
    }
    
    private func getAccountData(){
        getAccountInfo.shared.getData { (data) in
            self.Info = data
            self.setUp()
            //print(self.Info)
        }
    }
    
    private func setUp(){
        activityIndicator.stopAnimating()
        nameLabel.text = Info.fName! + " " + Info.lName!
        emailLabel.text = user?.email
        phnoLabel.text = Info.phno
        locationLabel.text = Info.location
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! EditViewController
        destVC.Info = Info
        destVC.tag = sender as! Int
        
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
            do {
                       try Auth.auth().signOut()
                   }
                   catch let signOutError as NSError {
                       print ("Error signing out: %@", signOutError)
                   }
                   
                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let initial = storyboard.instantiateInitialViewController()
                   self.view.window?.rootViewController = initial
                   self.view.window?.makeKeyAndVisible()
        }
    
    
    @IBAction func editProfileTapped(_ sender: Any) {
        let tag = 1
        performSegue(withIdentifier: Consatnts.accountToEditSegue, sender: tag)
    }
    
    
    @IBAction func changePasswordTapped(_ sender: Any) {
        let tag = 2
        performSegue(withIdentifier: Consatnts.accountToEditSegue, sender: tag)
    }
    
    
    }


