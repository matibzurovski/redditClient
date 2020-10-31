//
//  PostsViewController.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import UIKit

class PostsViewController: UITableViewController {
    
    // MARK: - Properties
    
    var presenter: PostsPresenter?
    
    private var posts: [PostData] = [] {
        didSet {
            tableView.reloadData()
        }
    }
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Interface
    
    func updatePosts(_ posts: [PostData]) {
        self.posts = posts
    }
    
    // MARK: - Table view
    
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
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectPost(posts[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        presenter?.prepareForSegue(segue)
    }
}

// MARK: - PostTableViewCellDelegate
extension PostsViewController: PostTableViewCellDelegate {
    
    func postTableViewCell(didTapDismiss cell: PostTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        tableView.beginUpdates()
        posts.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .bottom)
        tableView.endUpdates()
    }
}
