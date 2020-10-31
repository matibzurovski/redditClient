//
//  UIKit+RedditClient.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import UIKit

fileprivate let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func load(url: URL) {
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            /// Image is available on cache
            DispatchQueue.main.async {
                self.image = imageFromCache
            }
        } else {
            /// Image is not available on cache, so we will download it and save it for future use.
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                        imageCache.setObject(image, forKey: url as AnyObject)
                    }
                }
            }
        }
    }
}
