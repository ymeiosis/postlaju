//
//  CommentsViewController.swift
//  postlaju
//
//  Created by Ying Mei Lum on 24/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CommentsViewController: UIViewController {
    var currentUserID : String = ""
    var ref : DatabaseReference!
    var comments : [Comment] = []
    var selectedIdea : Idea = Idea()
    
    @IBOutlet weak var commenterName: UILabel!
    
    @IBOutlet weak var profileimageview: UIImageView!
    
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBAction func commentBtn(_ sender: Any) {
        createComment()
    }
    
    
    @IBOutlet weak var tableview: UITableView! {
        didSet {
            tableview.dataSource = self
            tableview.rowHeight = 30
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        observeComments()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func observeComments() {

    
    }
    
    func createComment() {
//        if let uid = Auth.auth().currentUser?.uid,
//            let comment = commentTextField.text,
//            let commenterID = commenterName.text {
//
//            guard let cell = tableview.dequeueReusableCell(withIdentifier: "commentcell") as? CommentTableViewCell else {return UITableViewCell()}
//            let aComment = comments[indexPath.row]
//
//            //post comment to database
//            let commentRef = self.ref.child("comments").childByAutoId()
//
//            let commentPost : [String : Any] = ["comment" : comment, "commenterID" : commenterID ]
//
//            commentRef.setValue(commentPost)
//            ref.child("users").child(uid).child("comments").child(commentRef.key).setValue(commentPost)
//
//            cell.userLabel.text = aComment.commenterID
//            cell.commentbox.text = aComment.comment
    }
}

extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CommentTableViewCell else {return UITableViewCell()}
        let aComment = comments[indexPath.row]
//
//        ref.child("users").child(aComment.userID).child("profilePicURL").observeSingleEvent(of: .value) { (snapshot) in
//            let commenterProfilePicURL = snapshot.value as? String ?? "No profilepic in snapshot"
//
//            if let imageViewForCell = cell.profileImageView {
//                self.getImage(commenterProfilePicURL, imageViewForCell)
//            }
//        }
//
//
//        ref.child("users").child(aComment.userID).child("firstname").observeSingleEvent(of: .value) { (snapshot) in
//            let commenterName = snapshot.value as? String ?? "No name in snapshot"
//            cell.nameLabel.text = commenterName
//        }
//
        cell.userLabel.text = aComment.commenterID
        cell.commentbox.text = aComment.comment

        return cell

//        }

    }
    
    
}
