//
//  Api.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import Foundation

class Api {
    
    static let shared = Api()
    
    fileprivate let service: ApiService
    
    private init() {
        service = ApiService(baseUrl: URL(string: "https://reddit.com")!)
    }
    
    func getTopPosts(request: TopPostsRequest, completion: @escaping (ApiResponse<ListingResponse>) -> Void) {
        service.perform(request: request, completion: completion)
    }
    
}
