//
//  PostTableViewCell.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import UIKit

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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.image = nil
    }
    
    func load(viewModel: PostViewModel) {
        unreadStatusView.isHidden = !viewModel.isUnread
        usernameLabel.text = viewModel.username
        dateTimeLabel.text = viewModel.dateTime?.timeAgo
        load(thumbnail: viewModel.thumbnail)
        titleLabel.text = viewModel.title
        commentsLabel.text = viewModel.comments.commentsFormatted
    }
    
    private func load(thumbnail: String?) {
        thumbnailImageView.load(imageUrl: thumbnail) { success in
            self.thumbnailImageView.isHidden = !success
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
