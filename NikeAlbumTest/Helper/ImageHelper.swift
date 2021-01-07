//
//  ImageHelper.swift
//  SimpleCardFramework
//
//  Created by YICHUN ZHANG on 10/1/20.
//  Copyright © 2020 Xevo. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func load(urlStr: String?) {
        guard let urlStr = urlStr else
        {
            return
        }
        guard let url = URL(string: urlStr) else {
            return
        }
        
        if let cachedImage = imageCache.object(forKey: urlStr as NSString)  {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        imageCache.setObject(image, forKey: urlStr as NSString)
                    }
                }
            }
        }
    }
}

