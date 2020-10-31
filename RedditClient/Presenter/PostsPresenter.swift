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
        let details = [
                "Detail 0",
                "Detail 1",
                "Detail 2",
                "Detail 3",
                "Detail 4",
                "Detail 5",
                "Detail 6",
                "Detail 7",
                "Detail 8",
                "Detail 9",
                "Detail 10",
                "Detail 11"
            ]
        viewController.updateDetails(details)
    }
}
