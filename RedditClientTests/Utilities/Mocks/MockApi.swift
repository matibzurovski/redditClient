//
//  MockApi.swift
//  RedditClientTests
//
//  Created by Matias Bzurovski on 01/11/2020.
//

import Foundation
@testable import RedditClient

class MockApi: Api {
    
    var getTopPostsRequestParam: TopPostsRequest?
    var getTopPostsCompletionParam: ((ApiResponse<ListingResponse>) -> Void)?
    var getTopPostsResult = MockApiCall()
    func getTopPosts(request: TopPostsRequest, completion: @escaping (ApiResponse<ListingResponse>) -> Void) -> ApiCall {
        getTopPostsRequestParam = request
        getTopPostsCompletionParam = completion
        return getTopPostsResult
    }
}
