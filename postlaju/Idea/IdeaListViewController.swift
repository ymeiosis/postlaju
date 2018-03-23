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
    
    
    var currentUserID : String = ""
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
        if (Auth.auth().currentUser?.uid) != nil {
            currentUserID = (Auth.auth().currentUser?.uid)!}

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
//                if let currentUserID = Auth.auth().currentUser?.uid {
//                    ref.child("users/\(currentUserID)/ideas").observe(.childAdded, with: { (snapshot) in
//
//                        guard let ideaDict = snapshot.value as? [String : Any] else {return}
//                        let anidea = Idea(uid: snapshot.key, dict: ideaDict)
//
//                        DispatchQueue.main.async {
//                            self.ideas.append(anidea)
//                            let indexPath = IndexPath(row: self.ideas.count - 1, section: 0)
//                            self.tableview.insertRows(at: [indexPath], with: .automatic)
//                        }
//                    })
//
//                    self.tableview.reloadData()
//                }
//
        //
        ref.child("users").child(currentUserID).child("ideas").observe(.childAdded) { (snapshot) in
            
            self.ref.child("ideas").child(snapshot.key).observeSingleEvent(of: .value, with: { (snapshot) in
                guard let IdeaDict = snapshot.value as? [String:Any] else {return}
                let anIdea = Idea(uid: snapshot.key, dict: IdeaDict)
                
                DispatchQueue.main.async {
                        self.ideas.append(anIdea)
                        let indexPath = IndexPath(row: self.ideas.count - 1, section: 0)
                    self.tableview.insertRows(at: [indexPath], with: .automatic)
                    
                }
            })
        }
    
        //        let currentUserID = getUser().getCurrentUserID()
//
//        ref.child("ideas").queryOrdered(byChild: "date").observe(.childAdded) { (snapshot) in
//            guard let dict = snapshot.value as? [String : Any] else {return}
//            let anIdea = Idea(uid: snapshot.key, dict: dict)
//
//            DispatchQueue.main.async {
//                if anIdea.posterID == currentUserID {
//                    self.ideas.append(anIdea)
//                    self.tableview.reloadData()
//                }
//            }
//        }
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ideas.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            guard let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? IdeaTableViewCell else {return UITableViewCell()}
            
            let selectedIdea = ideas[indexPath.row]
            
            cell.title.text = selectedIdea.caption
            cell.status.text = selectedIdea.status
            cell.date.text = String(selectedIdea.date)
            
            return cell
        }
    }


extension IdeaListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "IdeaDetailViewController") as? IdeaDetailViewController else {return}
        let selectedIdea = ideas[indexPath.row]
        vc.selectedIdea = selectedIdea
        navigationController?.pushViewController(vc, animated: true)
    }
}

