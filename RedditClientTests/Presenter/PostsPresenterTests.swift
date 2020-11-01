//
//  PostsPresenterTests.swift
//  RedditClientTests
//
//  Created by Matias Bzurovski on 01/11/2020.
//

import XCTest
@testable import RedditClient

class PostsPresenterTests: XCTestCase {

    private var presenter: PostsPresenter!
    private var view: MockPostsView!
    private var api: MockApi!
    
    override func setUpWithError() throws {
        view = .init()
        api = .init()
        presenter = PostsPresenter(view: view, api: api)
    }
    
    // MARK: - View did load

    func testViewDidLoad_InvokesApi() {
        /// Test that the corresponding method is invoked on the Api.
        XCTAssertNil(api.getTopPostsRequestParam)
        presenter.viewDidLoad()
        
        guard let request = api.getTopPostsRequestParam else {
            return XCTFail("Expected a request to Api.getTopPosts()")
        }
        XCTAssertEqual(request.perPage, 10)
        XCTAssertNil(request.page)
    }
    
    func testViewDidLoad_SuccessScenario() {
        /// Test the scenario where the Api call succeeds
        presenter.viewDidLoad()
        
        guard let completion = api.getTopPostsCompletionParam else {
            return XCTFail("Expected to find a completion handler")
        }
        
        let data = PostData.random
        let response = buildListingResponse(itemsData: [data])
        
        XCTAssertNil(view.addPostsParam)
        completion(.success(response))
        
        guard let addedPosts = view.addPostsParam else {
            return XCTFail("Expected a call to add posts on the view")
        }
        
        XCTAssertEqual(addedPosts.count, 1)
        XCTAssertEqual(addedPosts[0].title, data.title)
        XCTAssertEqual(addedPosts[0].username, data.author)
        XCTAssertEqual(addedPosts[0].thumbnail, data.thumbnail)
        XCTAssertEqual(addedPosts[0].fullSizeImage, data.fullSizeImage)
        XCTAssertEqual(addedPosts[0].dateTime, data.dateTime)
        XCTAssertEqual(addedPosts[0].comments, data.comments)
        XCTAssertTrue(addedPosts[0].isUnread)
    }
    
    func testViewDidLoad_FailureScenario() {
        /// Test the scenario where the Api call fails
        presenter.viewDidLoad()
        
        guard let completion = api.getTopPostsCompletionParam else {
            return XCTFail("Expected to find a completion handler")
        }
        
        completion(.failure(NSError.random))
        
        XCTAssertNil(view.addPostsParam)
    }
    
    // MARK: - Did pull to refresh
    
    func testDidPullToRefresh_CancelFetch() {
        /// Test that when the view pulls to refresh, we cancel the existing fetch
        let call = MockApiCall()
        api.getTopPostsResult = call
        presenter.viewDidLoad() /// So that the call is set on the PostsPresenter's `lastCall`.
        
        XCTAssertFalse(call.cancelCalled)
        presenter.didPullToRefresh()
        XCTAssertTrue(call.cancelCalled)
    }
    
    func testDidPullToRefresh_ClearPostsOnView() {
        /// Test that when the view pulls to refresh, we clear the posts on the view
        XCTAssertFalse(view.clearPostsCalled)
        presenter.didPullToRefresh()
        XCTAssertTrue(view.clearPostsCalled)
    }
    
    func testDidPullToRefresh_FetchesNewPosts() {
        /// Test that when the view pulls to refresh, we fetch new posts on the Api
        XCTAssertNil(api.getTopPostsRequestParam)
        presenter.didPullToRefresh()
        XCTAssertNotNil(api.getTopPostsRequestParam)
    }
    
    // MARK: - Did dismiss posts
    
    func testDidDismissPosts_CancelFetch() {
        /// Test that when the view pulls to refresh, we cancel the existing fetch
        let call = MockApiCall()
        api.getTopPostsResult = call
        presenter.viewDidLoad() /// So that the call is set on the PostsPresenter's `lastCall`.
        
        XCTAssertFalse(call.cancelCalled)
        presenter.didDismissPosts()
        XCTAssertTrue(call.cancelCalled)
    }
    
    func testDidDismissPosts_ClearPostsOnView() {
        /// Test that when the view dismisses posts, we clear the posts on the view
        XCTAssertFalse(view.clearPostsCalled)
        presenter.didDismissPosts()
        XCTAssertTrue(view.clearPostsCalled)
    }
    
    // MARK: - Did select post
    
    func testDidSelectPost() {
        /// Test taht when a post is selected, we perform the corresponding segue and replace the post view model
        let post = PostViewModel.randomUnread
        presenter.didSelectPost(post)
        
        XCTAssertEqual(view.performSegueIdentifierParam, "detail")
        
        guard let oldPost = view.replacePostOldPostParam, let newPost = view.replacePostNewPostParam else {
            return XCTFail("Expected a call to replace the post view model")
        }
        
        XCTAssertEqual(post, oldPost)
        let expectedNew = PostViewModel(title: post.title, username: post.username, thumbnail: post.thumbnail, fullSizeImage: post.fullSizeImage, dateTime: post.dateTime, comments: post.comments, isUnread: false)
        XCTAssertEqual(expectedNew, newPost)
    }
    
    // MARK: - Will display last post
    
    func testWillDisplayLastPost_WithoutNextPage() {
        /// Test the scenario where the last post is displayed but there is no nextPage to load
        presenter.willDisplayLastPost()
        XCTAssertNil(api.getTopPostsRequestParam)
    }
    
    func testWillDisplayLastPost_WithNextPage() {
        /// Test the scenario where the last post is displayed and there is a nextPage to load
        presenter.viewDidLoad()
        guard let completion = api.getTopPostsCompletionParam else {
            return XCTFail("Expected a completion set for getTopPosts()")
        }
        
        let nextPage = String.random
        let response = buildListingResponse(next: nextPage)
        completion(.success(response))
        
        presenter.willDisplayLastPost()
        
        guard let request = api.getTopPostsRequestParam else {
            return XCTFail("Expected a request for getTopPosts()")
        }
        
        XCTAssertEqual(request.page, nextPage)
    }
    
    
    // MARK: - Utility
    
    private func buildListingResponse(previous: String? = nil, next: String? = nil, itemsData: [PostData] = []) -> ListingResponse {
        let items = itemsData.map { Post(type: "t3", data: $0) }
        let data = Listing(previous: previous, next: next, items: items)
        return ListingResponse(type: "Listing", data: data)
    }

}

