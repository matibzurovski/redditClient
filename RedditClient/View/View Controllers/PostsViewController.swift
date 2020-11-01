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
            navigationItem.rightBarButtonItem?.isEnabled = !posts.isEmpty
        }
    }
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        setUpPullToRefresh()
        addClearButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        presenter?.prepareForSegue(segue)
    }
    
    // MARK: - Interface
    
    func addPosts(_ posts: [PostViewModel]) {
        DispatchQueue.main.async {
            self.posts.append(contentsOf: posts)
            self.tableView.reloadData()
            self.endRefreshing()
        }
    }
    
    func clearPosts() {
        DispatchQueue.main.async {
            self.posts.removeAll()
            self.tableView.reloadData()
        }
    }
    
    func replacePost(oldPost: PostViewModel, newPost: PostViewModel) {
        guard let index = posts.firstIndex(of: oldPost) else { return }
        posts[index] = newPost
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell {
            UIView.animate(withDuration: 0.25) {
                cell.load(viewModel: newPost)
            }
        }
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

// MARK: - UI logic
fileprivate extension PostsViewController {
    
    func setUpPullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func addClearButton() {
        let button = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearAction))
        button.isEnabled = false
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func pullToRefreshAction() {
        presenter?.didPullToRefresh()
        startRefreshing()
    }
    
    @objc private func clearAction() {
        presenter?.didClearPosts()
    }
    
    private func startRefreshing() {
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing..")
    }
    
    private func endRefreshing() {
        tableView.refreshControl?.endRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        }
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
