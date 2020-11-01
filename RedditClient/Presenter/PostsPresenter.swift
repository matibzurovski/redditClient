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
    
    static let itemsPerPage = 10
    
    fileprivate var selectedPost: PostViewModel?
    fileprivate var isLoading = false
    fileprivate var nextPage: String?
    
    init(viewController: PostsViewController) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        fetchPosts()
    }
    
    func didPullToRefresh() {
        nextPage = nil
        viewController.clearPosts()
        fetchPosts()
    }
    
    func didClearPosts() {
        viewController.clearPosts()
    }
    
    func didSelectPost(_ post: PostViewModel) {
        selectedPost = post
        let newPost = post.read
        viewController.performSegue(withIdentifier: "detail", sender: nil)
        viewController.replacePost(oldPost: post, newPost: newPost)
    }
    
    func willDisplayLastPost() {
        guard nextPage != nil else { return }
        fetchPosts()
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

// MARK: - Data loading
fileprivate extension PostsPresenter {
    
    func fetchPosts() {
        guard !isLoading else { return }
        isLoading = true
        
        let request = TopPostsRequest(perPage: PostsPresenter.itemsPerPage, page: nextPage)
        Api.shared.getTopPosts(request: request) { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response {
            case .success(let response):
                let posts = response.data.items.map { $0.data.asViewModel }
                self.nextPage = response.data.next
                self.viewController.addPosts(posts)
            case .failure(let error):
                print("Error when fetching top posts. \(error)")
            }
        }
    }
    
}

// MARK: - Utility
private extension PostData {
    
    var asViewModel: PostViewModel {
        return PostViewModel(title: title, username: author, thumbnail: thumbnail, fullSizeImage: fullSizeImage,
                             dateTime: dateTime, comments: comments, isUnread: true)
    }
}

private extension PostViewModel {
    
    var read: PostViewModel {
        return PostViewModel(title: title, username: username, thumbnail: thumbnail, fullSizeImage: fullSizeImage,
                             dateTime: dateTime, comments: comments, isUnread: false)
    }
}
