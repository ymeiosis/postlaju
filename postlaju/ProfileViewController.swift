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
//import FLAnimatedImage

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
//    {
//        didSet {
//
//            imageView.isUserInteractionEnabled = true
//            let tap = UITapGestureRecognizer(target: self, action: #selector(findImageButtonTapped))
//            imageView.addGestureRecognizer(tap)
//        }

//    }
    
    @IBOutlet weak var firstname: UILabel!
    
    @IBOutlet weak var lastname: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBAction func editBtn(_ sender: Any) {
    }
    
    @IBOutlet weak var numberOfIncompleteIdea: UILabel!
    @IBOutlet weak var numberOfUnstartedIdea: UIImageView!
    @IBOutlet weak var numberOfInProgressIdea: UILabel!
    @IBOutlet weak var numberOfCompleteIdea: UILabel!
    
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
        let user = Auth.auth().currentUser
        if let user = user {
            let currentUserID = user.uid
            
            ref.child("users").child(currentUserID).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let value = snapshot.value as? [String : Any] else {return}
                self.firstname.text = value["firstname"] as? String ?? ""
                self.lastname.text = value["lastname"] as? String ?? ""
                self.email.text = value["email"] as? String ?? ""
//                self.getImage(profilepic, self.imageview)
                
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
}
