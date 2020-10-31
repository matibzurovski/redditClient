//
//  PostTableViewCell.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import UIKit

struct PostData {
    let title: String
    let username: String
    let thumbnail: String?
    let fullSizeImage: String?
    let dateTime: Date?
    let comments: Int
    let isUnread: Bool
}

protocol PostTableViewCellDelegate: class {
    func postTableViewCell(didTapDismiss cell: PostTableViewCell)
}

class PostTableViewCell: UITableViewCell {
    
    static let identifier = "PostTableViewCell"
    
    weak var delegate: PostTableViewCellDelegate?
    
    @IBOutlet fileprivate weak var unreadStatusView: UIView!
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    @IBOutlet fileprivate weak var dateTimeLabel: UILabel!
    @IBOutlet fileprivate weak var thumbnailImageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var commentsLabel: UILabel!
    
    func load(data: PostData) {
        unreadStatusView.isHidden = !data.isUnread
        usernameLabel.text = data.username
        dateTimeLabel.text = data.dateTime?.timeAgo
        load(thumbnail: data.thumbnail)
        titleLabel.text = data.title
        commentsLabel.text = data.comments.commentsFormatted
    }
    
    private func load(thumbnail: String?) {
        if let thumbnail = thumbnail, let url = URL(string: thumbnail) {
            thumbnailImageView.load(url: url)
            thumbnailImageView.isHidden = false
        } else {
            thumbnailImageView.isHidden = true
        }
    }
}

// MARK: - Actions
fileprivate extension PostTableViewCell {
    
    @IBAction func dismissAction(_ sender: Any) {
        delegate?.postTableViewCell(didTapDismiss: self)
    }
}

// MARK: - Utility
private extension Int {
    
    var commentsFormatted: String {
        return self == 1 ? "1 comment" : "\(self) comments"
    }
}
