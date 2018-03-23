//
//  IdeaTableViewCell.swift
//  postlaju
//
//  Created by Ying Mei Lum on 22/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class IdeaTableViewCell: UITableViewCell{
        
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
