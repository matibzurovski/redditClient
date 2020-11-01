//
//  PostsPresenter.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import Foundation
import UIKit

class PostsPresenter {
    
    fileprivate let view: PostsView
    fileprivate let api: Api
    
    static let itemsPerPage = 10
    
    fileprivate var selectedPost: PostViewModel?
    fileprivate var lastCall: ApiCall?
    fileprivate var isLoading = false
    fileprivate var nextPage: String?
    
    init(view: PostsView, api: Api = DefaultApi.shared) {
        self.view = view
        self.api = api
    }
    
    func viewDidLoad() {
        fetchPosts()
    }
    
    func didPullToRefresh() {
        nextPage = nil
        cancelFetch()
        view.clearPosts()
        fetchPosts()
    }
    
    func didDismissPosts() {
        cancelFetch()
        view.clearPosts()
    }
    
    func didSelectPost(_ post: PostViewModel) {
        selectedPost = post
        let newPost = post.read
        view.performSegue(withIdentifier: "detail", sender: nil)
        view.replacePost(oldPost: post, newPost: newPost)
    }
    
    func willDisplayLastPost() {
        guard nextPage != nil else { return }
        fetchPosts()
    }
    
    func prepareForSegue(_ segue: UIStoryboardSegue) {
        if segue.identifier == "detail" {
            if let navigationController = segue.destination as? UINavigationController,
               let view = navigationController.topViewController as? DetailViewController,
               let post = selectedPost {
                let presenter = DetailPresenter(view: view, post: post)
                view.presenter = presenter
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
        lastCall = api.getTopPosts(request: request) { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response {
            case .success(let response):
                let posts = response.data.items.map { $0.data.asViewModel }
                self.nextPage = response.data.next
                self.view.addPosts(posts)
            case .failure(let error):
                print("Error when fetching top posts. \(error)")
            }
        }
    }
    
    func cancelFetch() {
        lastCall?.cancel()
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
