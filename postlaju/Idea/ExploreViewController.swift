//
//  ExploreViewController.swift
//  postlaju
//
//  Created by Ying Mei Lum on 21/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class ExploreViewController: UIViewController {
    
    var currentUserID : String = ""
    var ref : DatabaseReference!
    var ideas : [Idea] = []
    var filterIdeas : [Idea] = []
    
    @IBOutlet weak var tableview: UITableView! {
        didSet {
            tableview.dataSource = self
            tableview.delegate = self
            tableview.rowHeight = 75
        }
    }
    
    @IBOutlet weak var searchbar: UISearchBar! {
        didSet {
//            searchBar.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        observeIdeas()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func observeIdeas() {
//        ref.child("users").child(currentUserID).child("ideas").observe(.childAdded) { (snapshot) in
//
//            self.ref.child("ideas").child(snapshot.key).observeSingleEvent(of: .value, with: { (snapshot) in
//                guard let IdeaDict = snapshot.value as? [String:Any] else {return}
//                let anIdea = Idea(uid: snapshot.key, dict: IdeaDict)
//
//                DispatchQueue.main.async {
//                    self.ideas.append(anIdea)
//                    let indexPath = IndexPath(row: self.ideas.count - 1, section: 0)
//                    self.tableview.insertRows(at: [indexPath], with: .automatic)
//
//                }
//            })
        }
    
    
}

extension ExploreViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedIdea = ideas[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "IdeaDetailViewController") as? IdeaDetailViewController else {return}
        vc.selectedIdea = selectedIdea
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ExploreViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filterIdeas = ideas
            tableview.reloadData()
            return
        }
        self.tableview.reloadData()
        
    }
}

extension ExploreViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterIdeas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = Bundle.main.loadNibNamed("IdeaTableViewCell", owner: nil, options: nil)?.first as? IdeaTableViewCell else {return UITableViewCell()}
        
        cell.selectionStyle = .none
        
        let currentIdea = filterIdeas[indexPath.row]
        return cell
    }
}

