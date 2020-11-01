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
    
    fileprivate var selectedPost: PostViewModel?
    fileprivate var isLoading = false
    
    init(viewController: PostsViewController) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        fetchPosts()
    }
    
    func didSelectPost(_ post: PostViewModel) {
        selectedPost = post
        viewController.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    func willDisplayLastPost() {
        var posts: [PostViewModel] = []
        for index in 0..<4 {
            let data = PostViewModel(title: "Can't get much smoother than this guy. Can't get much smoother than this guy. Can't get much smoother than this guy. Can't get much smoother than this guy. Can't get much smoother than this guy.", username: "sameFunnyName", thumbnail: nil, fullSizeImage: nil, dateTime: Date().addingTimeInterval(-4234), comments: index, isUnread: true)
            posts.append(data)
        }
        viewController.addPosts(posts)
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

fileprivate extension PostsPresenter {
    
    func fetchPosts() {
        guard !isLoading else { return }
        isLoading = true
        
        let request = TopPostsRequest()
        Api.shared.getTopPosts(request: request) { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response {
            case .success(let response):
                let posts = response.data.items.map { $0.data.asViewModel }
                self.viewController.addPosts(posts)
            case .failure(let error):
                print("Error when fetching top posts. \(error)")
            }
        }
    }
    
    func handlePostsResponse(_ response: ListingResponse) {
        
    }
    
}

private extension PostData {
    
    var asViewModel: PostViewModel {
        return PostViewModel(title: title, username: author, thumbnail: thumbnail, fullSizeImage: fullSizeImage, dateTime: dateTime, comments: comments, isUnread: true)
    }
}
