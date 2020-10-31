//
//  PostsPresenter.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import Foundation
import UIKit

class PostsPresenter {
    
    let viewController: PostsViewController
    
    fileprivate var selectedPost: PostData?
    
    init(viewController: PostsViewController) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        var posts: [PostData] = []
        for index in 0..<12 {
            if index == 3 {
                let data = PostData(title: "Can't get much smoother than this guy. Can't get much smoother than this guy. Can't get much smoother than this guy. Can't get much smoother than this guy. Can't get much smoother than this guy.", username: "sameFunnyName", thumbnail: nil, fullSizeImage: nil, dateTime: Date().addingTimeInterval(-4234), comments: index, isUnread: true)
                posts.append(data)
            } else {
            
                let data = PostData(title: "First new Keanu pic of the year", username: "sameFunnyName", thumbnail: "https://b.thumbs.redditmedia.com/UzwFlv-3K7cDKjf9jhUMXikn-6QzD1ZMRtzGSBTqBnk.jpg", fullSizeImage: "https://i.redd.it/2mt8fyb6d9w51.jpg", dateTime: Date().addingTimeInterval(-4234), comments: index, isUnread: true)
                posts.append(data)
            }
        }
        viewController.updatePosts(posts)
    }
    
    func didSelectPost(_ post: PostData) {
        selectedPost = post
        viewController.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    func prepareForSegue(_ segue: UIStoryboardSegue) {
        if segue.identifier == "detail" {
            if let navigationController = segue.destination as? UINavigationController,
               let destination = navigationController.topViewController as? DetailViewController,
               let post = selectedPost {
                let presenter = DetailPresenter(viewController: destination, post: post)
                destination.presenter = presenter
            }
        }
    }
}
