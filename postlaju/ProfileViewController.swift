//
//  ProfileViewController.swift
//  postlaju
//
//  Created by Ying Mei Lum on 21/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class ProfileViewController: UIViewController {
    var ideas : [Idea] = []
    
    var ref : DatabaseReference!
    
    var currentUserID : String = ""

    
    @IBAction func logoutBtnTapped(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let navVC = sb.instantiateViewController(withIdentifier: "mainNavigationController") as? UINavigationController else {return}
            present(navVC, animated: true, completion: nil)
        } catch {
        }
    }
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var lastname: UILabel!
    
    @IBAction func editBtn(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        if (Auth.auth().currentUser?.uid) != nil {
            currentUserID = (Auth.auth().currentUser?.uid)!
            observeCurrentUserInfo()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func observeCurrentUserInfo() {
        
    }
}
