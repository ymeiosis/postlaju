//
//  IdeaListViewController.swift
//  postlaju
//
//  Created by Ying Mei Lum on 21/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import FLAnimatedImage


class IdeaListViewController: UIViewController, UITableViewDataSource {

    
    var ref : DatabaseReference!
    var ideas : [Idea] = []
    @IBOutlet weak var imageview: FLAnimatedImage!
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var tableview: UITableView! {
        didSet {
            tableview.dataSource = self
            tableview.delegate = self
            tableview.rowHeight = 75
            
        }
    }
    
        
        override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        observeIdeas()
        FLAnimated()
            self.navigationController?.isNavigationBarHidden = true

        }
        
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    func FLAnimated() {
        
    }
    
    
        func observeIdeas() {
            
//            guard let userID = Auth.auth().currentUser?.uid else {return}

//            ref.child("users").child(userID).child("ideas").observe(.childAdded) { (snapshot) in
//                guard let ideaDict = snapshot.value as? [String:Any] else {return}
//                guard let anidea = Idea(uid: snapshot.key, dict: ideaDict) as? String else {return}
//                print("the idea is \(anidea)")
//
            
//                ref.child("users").child(userID).child("ideas").observe(.childAdded) { (snapshot) in
//                    guard let userDict = snapshot.value as? [String:Any] else {return}
//                    guard let anidea = userDict["idea"] as? String else {return}
//                    print("the title is \(anidea)")
//
//
//                    self.ref.child("ideas").child(snapshot.key).child(anidea).observe(.value, with: { (ideaSnapshot) in
//                        guard let ideaDict = ideaSnapshot.value as? [String:Any] else {return}
//                        let idea = Idea(uid: snapshot.key, userDict: userDict, dict: ideaDict)
            if let uid = Auth.auth().currentUser?.uid {
                ref.child("users/\(uid)/ideas").observe(.childAdded, with: { (snapshot) in
                    
                    guard let ideaDict = snapshot.value as? [String : Any] else {return}
                    let anidea = Idea(uid: snapshot.key, dict: ideaDict)
                    
                        DispatchQueue.main.async {
                        self.ideas.append(anidea)
                        let indexPath = IndexPath(row: self.ideas.count - 1, section: 0)
                        self.tableview.insertRows(at: [indexPath], with: .automatic)
                    }
                })
            
                self.tableview.reloadData()
            }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ideas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? IdeaTableViewCell else {return UITableViewCell()}
        
        cell.title.text = ideas[indexPath.row].caption
        cell.status.text = ideas[indexPath.row].status
        cell.date.text = String(ideas[indexPath.row].timestamp)
        
        return cell
    }
}

extension IdeaListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        guard let cell = tableView.cellForRow(at: indexPath) as? IdeaTableViewCell else {return}
//        cell.contentView.backgroundColor = UIColor.colourSelection()

        guard let vc = storyboard?.instantiateViewController(withIdentifier: "IdeaDetailViewController") as? IdeaDetailViewController else {return}
        let selectedIdea = ideas[indexPath.row]
        vc.selectedIdea = selectedIdea
        navigationController?.pushViewController(vc, animated: true)
    }
}

