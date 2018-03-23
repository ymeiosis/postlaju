//
//  CommentTableViewCell.swift
//  postlaju
//
//  Created by Ying Mei Lum on 24/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var profileimageview: UIImageView!
    
    @IBOutlet weak var commentbox: UITextField!
    
    @IBOutlet weak var userLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
