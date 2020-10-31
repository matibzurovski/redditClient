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
    fileprivate let post: PostData
    
    init(viewController: DetailViewController, post: PostData) {
        self.viewController = viewController
        self.post = post
    }
    
    func viewDidLoad() {
        viewController.load(post: post)
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
