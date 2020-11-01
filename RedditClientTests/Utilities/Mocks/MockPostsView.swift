//
//  MockPostsView.swift
//  RedditClientTests
//
//  Created by Matias Bzurovski on 01/11/2020.
//

import UIKit
@testable import RedditClient

class MockPostsView: UIViewController, PostsView {
    
    var addPostsParam: [PostViewModel]?
    func addPosts(_ posts: [PostViewModel]) {
        addPostsParam = posts
    }
    
    var clearPostsCalled = false
    func clearPosts() {
        clearPostsCalled = true
    }
    
    var replacePostOldPostParam: PostViewModel?
    var replacePostNewPostParam: PostViewModel?
    func replacePost(oldPost: PostViewModel, newPost: PostViewModel) {
        replacePostOldPostParam = oldPost
        replacePostNewPostParam = newPost
    }
    
    var performSegueIdentifierParam: String?
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        performSegueIdentifierParam = identifier
    }
}
