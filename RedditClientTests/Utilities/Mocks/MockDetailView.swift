//
//  MockDetailView.swift
//  RedditClientTests
//
//  Created by Matias Bzurovski on 01/11/2020.
//

import UIKit
@testable import RedditClient

class MockDetailView: UIViewController, DetailView {
    
    var loadPostParam: PostViewModel?
    var loadAllowFullSizeImageParam: Bool?
    func load(post: PostViewModel, allowFullSizeImage: Bool) {
        loadPostParam = post
        loadAllowFullSizeImageParam = allowFullSizeImage
    }
    
    var performSegueIdentifierParam: String?
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        performSegueIdentifierParam = identifier
    }
}
