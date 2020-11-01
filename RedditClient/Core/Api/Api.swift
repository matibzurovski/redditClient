//
//  Api.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import Foundation

protocol Api {
    
    func getTopPosts(request: TopPostsRequest, completion: @escaping (ApiResponse<ListingResponse>) -> Void) -> ApiCall
}

class DefaultApi: Api {
    
    static let shared = DefaultApi()
    
    fileprivate let service: ApiService
    
    private init() {
        service = ApiService(baseUrl: URL(string: "https://reddit.com")!)
    }
    
    func getTopPosts(request: TopPostsRequest, completion: @escaping (ApiResponse<ListingResponse>) -> Void) -> ApiCall {
        return service.perform(request: request, completion: completion)
    }
    
}
