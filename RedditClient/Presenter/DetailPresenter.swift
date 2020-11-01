//
//  DetailPresenter.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import Foundation
import UIKit

class DetailPresenter {
    
    fileprivate let viewController: DetailViewController
    fileprivate let post: PostViewModel
    
    init(viewController: DetailViewController, post: PostViewModel) {
        self.viewController = viewController
        self.post = post
    }
    
    func viewDidLoad() {
        let allowFullSizeImage = post.fullSizeImage?.isImageUrl ?? false
        viewController.load(post: post, allowFullSizeImage: allowFullSizeImage)
    }
    
    func imageTapped() {
        viewController.performSegue(withIdentifier: "fullSizeImage", sender: nil)
    }
    
    func prepareForSegue(_ segue: UIStoryboardSegue) {
        if segue.identifier == "fullSizeImage" {
            if let navigationController = segue.destination as? UINavigationController, let destination = navigationController.topViewController as? FullSizeImageViewController {
                destination.fullSizeImage = post.fullSizeImage
            }
        }
    }
}

// MARK: - Utility
private extension String {
    
    var isImageUrl: Bool {
        let pathExtension = (self as NSString).pathExtension
        let imageFormats = ["jpg", "jpeg", "png", "gif"]
        return imageFormats.contains(pathExtension)
    }
    
}
