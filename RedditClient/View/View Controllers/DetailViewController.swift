//
//  DetailViewController.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: DetailPresenter?
    
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
    
    func load(post: PostViewModel?, allowFullSizeImage: Bool) {
        if let post = post {
            usernameLabel.text = post.username
            loadImage(post: post, allowFullSizeImage: allowFullSizeImage)
            titleLabel.text = post.title
            dataStackView.isHidden = false
            emptyDetailLabel.isHidden = true
        } else {
            dataStackView.isHidden = true
            emptyDetailLabel.isHidden = false
        }
        
    }
    
    // MARK: - Private methods
    
    private func loadImage(post: PostViewModel, allowFullSizeImage: Bool) {
        if let thumbnail = post.thumbnail, let url = URL(string: thumbnail) {
            thumbnailImageView.load(url: url)
            if allowFullSizeImage {
                setUpImageGesture()
            }
        } else {
            thumbnailImageView.superview?.isHidden = true
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

