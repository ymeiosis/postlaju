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
    var timestamp : Int = 0
    var description : String = ""
    
    init () {
        
    }
    
    
    
    init(uid : String, dict : [String:Any]) {
        self.uid = uid
        self.status = dict["status"] as? String ?? "No donorID"
        self.posterID = dict["posterID"] as? String ?? "No donorID"
        self.postedPicUrl = dict["postedPicUrl"] as? String ?? "No postedPicUrl"
        self.caption = dict["caption"] as? String ?? "No postedPicUrl"
        self.likes = dict["likes"] as? [String : Bool] ?? [:]
        self.timestamp = dict["timestamp"] as? Int ?? 0
    }
    
    init(uid: String, userDict: [String:Any], dict: [String:Any]) {
        self.uid = uid
        self.status = userDict["status"] as? String ?? "-"
        self.caption = userDict["caption"] as? String ?? "-"
        self.timestamp = dict["timestamp"] as? Int ?? 0
    }
    
    enum status : String {
        case Incomplete = "Incomplete"
        case Unstarted = "Unstarted"
        case InProgress = "InProgress"
        case Complete = "Complete"
    }
}
