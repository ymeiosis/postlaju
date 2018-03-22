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


class IdeaListViewController: UIViewController, UITableViewDataSource {

    
    var ref : DatabaseReference!
    var ideas : [Idea] = []
    
    @IBOutlet weak var tableview: UITableView!
//        {
//        didSet {
//            tableView.dataSource = self
//            tableView.delegate = self
//
//        }
//    }
    
        
        override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        tableview.rowHeight = 150
        observeIdeas()
        tableview.dataSource = self

        }
        
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
        
        func observeIdeas() {
            
            guard let userID = Auth.auth().currentUser?.uid else {return}

            ref.child("users").child(userID).child("ideas").observe(.childAdded) { (snapshot) in
                guard let patientDrugDict = snapshot.value as? [String:Any] else {return}
                guard let dosage = patientDrugDict["Dosage"] as? String else {return}
                print("the medicine amount is \(dosage)")
                
                
//                self.ref.child("ideas").child(snapshot.key).child(dosage).observe(.value, with: { (drugSnapshot) in
//                    guard let ideasDict = drugSnapshot.value as? [String:Any] else {return}
//                    let idea = Idea
//                    (uid: snapshot.key, patientDrugDict: patientDrugDict, dict: drugsDict)
//
//                    DispatchQueue.main.async {
//                        self.ideas.append(idea)
//                        let indexPath = IndexPath(row: self.drugs.count - 1, section: 0)
//                        self.tableview.insertRows(at: [indexPath], with: .automatic)
//                    }
//                })
                
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
        
        
//        let ideaUID = ideas[indexPath.row].uid
//
//        ref.child("ideas").child(ideaUID).child("Donor").observe(.value, with: { (snapshot) in
//            let donationCount = snapshot.childrenCount
//            print("Donation Count: \(donationCount)")
//            cell.countLabel.text = "\(donationCount)"
//        })
    
        return cell
    }
    

}

//extension IdeaListViewController : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        guard let cell = tableView.cellForRow(at: indexPath) as? IdeaTableViewCell else {return}
//        cell.contentView.backgroundColor = UIColor.colourSelection()
//
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: "EventViewController") as? EventViewController else {return}
//
//        let eventDonor = hospitalEvents[indexPath.row]
//
//        vc.selectedEvent = eventDonor
//
//        //        DispatchQueue.main.async {
//
//        self.navigationController?.pushViewController(vc, animated: true)
//
//        //    }
//    }
//
//}

