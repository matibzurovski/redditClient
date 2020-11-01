//
//  DetailPresenterTests.swift
//  RedditClientTests
//
//  Created by Matias Bzurovski on 01/11/2020.
//

import XCTest
@testable import RedditClient

class DetailPresenterTests: XCTestCase {

    private var presenter: DetailPresenter!
    private var view: MockDetailView!
    private var post: PostViewModel!
    
    override func setUpWithError() throws {
        view = .init()
        post = .randomUnread
        presenter = DetailPresenter(view: view, post: post)
    }
    
    // MARK: - View did load
    
    func testViewDidLoad_AllowFullSizeImageFalse() {
        /// Test the scenario where the post doesn't have a full size image
        
        XCTAssertNil(view.loadPostParam)
        presenter.viewDidLoad()
        
        XCTAssertEqual(view.loadPostParam, post)
        XCTAssertFalse(view.loadAllowFullSizeImageParam ?? true)
    }
    
    func testViewDidLoad_AllowFullSizeImageTrue() {
        /// Test the scenario where the post has a full size image
        
        let fullSizeImage = "www.reddit.com/image.png"
        post = PostViewModel(title: .random, username: .random, thumbnail: .random, fullSizeImage: fullSizeImage, dateTime: Date(), comments: .random, isUnread: true)
        presenter = DetailPresenter(view: view, post: post)
        
        XCTAssertNil(view.loadPostParam)
        presenter.viewDidLoad()
        
        XCTAssertEqual(view.loadPostParam, post)
        XCTAssertTrue(view.loadAllowFullSizeImageParam ?? false)
    }
    
    // MARK: - Image tapped
    
    func testImageTapped() {
        /// Test that the corresponding segue is performed when the image is tapped.
        XCTAssertNil(view.performSegueIdentifierParam)
        presenter.imageTapped()
        XCTAssertEqual(view.performSegueIdentifierParam, "fullSizeImage")
    }
}
