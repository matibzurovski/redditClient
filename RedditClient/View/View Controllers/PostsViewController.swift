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
    
    private var posts: [PostViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        presenter?.prepareForSegue(segue)
    }
    
    // MARK: - Interface
    
    func addPosts(_ posts: [PostViewModel]) {
        self.posts.append(contentsOf: posts)
    }
    
    func replacePost(oldPost: PostViewModel, newPost: PostViewModel) {
        guard let index = posts.firstIndex(of: oldPost) else { return }
        posts[index] = newPost
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
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
        let viewModel = posts[indexPath.row]
        cell.load(viewModel: viewModel)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectPost(posts[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = posts.count - 1
        guard indexPath.row == lastItem else { return }
        presenter?.willDisplayLastPost()
    }
}

// MARK: - PostTableViewCellDelegate
extension PostsViewController: PostTableViewCellDelegate {
    
    func postTableViewCell(didTapDismiss cell: PostTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        tableView.beginUpdates()
        posts.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        tableView.endUpdates()
    }
}
