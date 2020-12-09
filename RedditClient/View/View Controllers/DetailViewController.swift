//
//  DetailViewController.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import UIKit

protocol DetailView: UIViewController {
    func load(post: PostViewModel, allowFullSizeImage: Bool)
}

class DetailViewController: UIViewController, DetailView {
    
    // MARK: - Properties
    
    weak var presenter: DetailPresenter?
    
    @IBOutlet fileprivate weak var dataStackView: UIStackView!
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    @IBOutlet fileprivate weak var thumbnailImageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var emptyDetailLabel: UILabel!
    
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
    
    func load(post: PostViewModel, allowFullSizeImage: Bool) {
        usernameLabel.text = post.username
        loadImage(post: post, allowFullSizeImage: allowFullSizeImage)
        titleLabel.text = post.title
        dataStackView.isHidden = false
        emptyDetailLabel.isHidden = true
    }
    
    // MARK: - Private methods
    
    private func loadImage(post: PostViewModel, allowFullSizeImage: Bool) {
        thumbnailImageView.load(imageUrl: post.thumbnail) { success in
            self.thumbnailImageView.superview?.isHidden = !success
        }
        if allowFullSizeImage {
            setUpImageGesture()
        }
    }
    
    private func setUpImageGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
        thumbnailImageView.addGestureRecognizer(gesture)
    }
    
    @objc private func handleImageTap() {
        presenter?.imageTapped()
    }
    
    
    
}

