//
//  DetailPresenter.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import Foundation
import UIKit

class DetailPresenter {
    
    fileprivate let view: DetailView
    fileprivate let post: PostViewModel
    
    init(view: DetailView, post: PostViewModel) {
        self.view = view
        self.post = post
    }
    
    func viewDidLoad() {
        let allowFullSizeImage = post.fullSizeImage?.isImageUrl ?? false
        view.load(post: post, allowFullSizeImage: allowFullSizeImage)
    }
    
    func imageTapped() {
        view.performSegue(withIdentifier: "fullSizeImage", sender: nil)
    }
    
    func prepareForSegue(_ segue: UIStoryboardSegue) {
        if segue.identifier == "fullSizeImage" {
            if let navigationController = segue.destination as? UINavigationController, let destination = navigationController.topViewController as? FullSizeImageViewController {
                destination.fullSizeImage = post.fullSizeImage
            }
        }
    }
}
