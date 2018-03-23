//
//  Gifu.swift
//  postlaju
//
//  Created by Ying Mei Lum on 22/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import Foundation
import UIKit
import Gifu

extension UIViewController {
    class MyImageView: UIImageView, GIFAnimatable {
        public lazy var animator: Animator? = {
            return Animator(withDelegate: self)
        }()
        
        override public func display(_ layer: CALayer) {
            updateImageIfNeeded()
        }
    }
    class CustomAnimatedView: UIView, GIFAnimatable {
        public lazy var animator: Animator? = {
            return Animator(withDelegate: self)
        }()
        
        override public func display(_ layer: CALayer) {
            updateImageIfNeeded()
        }
    }
}
