//
//  GetUser.swift
//  postlaju
//
//  Created by Ying Mei Lum on 23/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase



class getUser {
    
    var ref : DatabaseReference!
    
    init() {
        ref = Database.database().reference()
    }
    
    func getCurrentUserID() -> String {
        guard let id = Auth.auth().currentUser else {return ""}
        return id.uid
    }
}
