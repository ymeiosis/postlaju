//
//  Comment.swift
//  postlaju
//
//  Created by Ying Mei Lum on 22/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import Foundation

class Comment {
    var commentID : String = ""
    var comment : String = ""
    var timeStamp : Int = 0
    var commenterID : String = ""
    
    init() {
        
    }
    
    init(commentID : String, dict : [String : Any]) {
        self.commentID = commentID
        self.comment = dict["comment"] as? String ?? "No comments"
        self.timeStamp = dict["timeStamp"] as? Int ?? 0
        self.commenterID = dict["commenterID"] as? String ?? "No commenterID"
    }
}
