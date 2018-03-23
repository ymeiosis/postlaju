//
//  Idea.swift
//  postlaju
//
//  Created by Ying Mei Lum on 22/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import Foundation

class Idea {
    var uid : String = ""
    var posterID : String = ""
    var postedPicUrl : String = ""
    var caption : String = ""
    var status : String = ""
    var likes : [String : Bool] = [:]
    var dislikes : [String : Bool] = [:]
    var comments : [String : Bool] = [:]
    var location : String = ""
    var date : String = ""
    var description : String = ""
    
    init () {
        
    }
    
    
    
    init(uid : String, dict : [String:Any]) {
        self.uid = uid
        self.caption = dict["caption"] as? String ?? "No caption"
        self.status = dict["status"] as? String ?? "No status"
        
        self.posterID = dict["posterID"] as? String ?? "No posterID"
        self.postedPicUrl = dict["postedPicUrl"] as? String ?? "No postedPicUrl"
        self.likes = dict["likes"] as? [String : Bool] ?? [:]
        self.date = dict["date"] as? String ?? ""
    }
    
    init(uid: String, userDict: [String:Any], dict: [String:Any]) {
        self.uid = uid
        self.status = userDict["status"] as? String ?? "-"
        self.caption = userDict["caption"] as? String ?? "-"
        self.date = dict["date"] as? String ?? ""
        
    }
    
    enum status : String {
        case Incomplete = "Incomplete"
        case Unstarted = "Unstarted"
        case InProgress = "InProgress"
        case Complete = "Complete"
    }
}
