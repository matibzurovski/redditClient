//
//  DetailViewController.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    var post: PostData?
    
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    @IBOutlet fileprivate weak var fullSizeImageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    private func loadData() {
        usernameLabel.text = post?.username
        loadFullSizeImage()
        titleLabel.text = post?.title
    }
    
    private func loadFullSizeImage() {
        if let fullSizeImage = post?.fullSizeImage, let url = URL(string: fullSizeImage) {
            fullSizeImageView.load(url: url)
            setUpImageGesture()
        } else {
            fullSizeImageView.superview?.isHidden = true
        }
    }
    
    private func setUpImageGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openFullSizeImage))
        fullSizeImageView.addGestureRecognizer(gesture)
    }
    
    @objc private func openFullSizeImage() {
        
    }
}

