//
//  PostsPresenter.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import Foundation

class PostsPresenter {
    
    let viewController: PostsViewController
    
    init(viewController: PostsViewController) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        var posts: [PostData] = []
        for index in 0..<12 {
            if index == 3 {
                let data = PostData(title: "Can't get much smoother than this guy. Can't get much smoother than this guy. Can't get much smoother than this guy. Can't get much smoother than this guy. Can't get much smoother than this guy.", username: "sameFunnyName", thumbnail: nil, dateTime: Date().addingTimeInterval(-4234), comments: index, isUnread: true)
                posts.append(data)
            } else {
                let data = PostData(title: "First new Keanu pic of the year", username: "sameFunnyName", thumbnail: "https://b.thumbs.redditmedia.com/UzwFlv-3K7cDKjf9jhUMXikn-6QzD1ZMRtzGSBTqBnk.jpg", dateTime: Date().addingTimeInterval(-4234), comments: index, isUnread: true)
                posts.append(data)
            }
        }
        viewController.updatePosts(posts)
    }
}
