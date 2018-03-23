//
//  GetImage.swift
//  postlaju
//
//  Created by Ying Mei Lum on 22/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
//MARK: GET IMAGE start
func getImage(_ urlString: String, _ imageView: UIImageView) {
    guard let url = URL.init(string: urlString) else {return}
    
    let session = URLSession.shared
    let task = session.dataTask(with: url) { (data, response, error) in
        if let validError = error {
            print(validError.localizedDescription)
        }
        if let validData = data {
            let image = UIImage(data: validData)
            
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
    }
    task.resume()
}
//MARK: GET IMAGE end
}

