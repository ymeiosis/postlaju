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
    var timestamp : Int = 0
    
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
    
}
