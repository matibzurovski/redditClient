//
//  PostsViewController.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import UIKit

class PostsViewController: UITableViewController {
    
    var presenter: PostsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    private var posts: [PostData] = [] {
        didSet {
            tableView.reloadData()
        }
    }
        
    func updatePosts(_ posts: [PostData]) {
        self.posts = posts
    }
    
    private var selectedPost: PostData?
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        let data = posts[indexPath.row]
        cell.load(data: data)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Move this to the presenter
        selectedPost = posts[indexPath.row]
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Move this to the presenter
        if segue.identifier == "detail" {
            if let navigationController = segue.destination as? UINavigationController, let destination = navigationController.topViewController as? DetailViewController {
                destination.post = selectedPost
            }
        }
    }
}

