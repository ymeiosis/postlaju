//
//  Pastel.swift
//  postlaju
//
//  Created by Ying Mei Lum on 22/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import Foundation
import UIKit
import Pastel

extension UIViewController {
    func pastelview() {
        
        let pastelView = PastelView(frame: view.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView.animationDuration = 3.0
        
        // Custom Color
        pastelView.setColors([UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1.0),
                              UIColor(red: 248/255, green: 248/255, blue: 124/255, alpha: 1.0),
                              UIColor(red: 248/255, green: 248/255, blue: 186/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)])
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
    }
}
