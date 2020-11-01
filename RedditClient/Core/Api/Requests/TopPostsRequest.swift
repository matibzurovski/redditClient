//
//  TopPostsRequest.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import Foundation

struct TopPostsRequest: ApiRequest {
    
    var httpMethod: HttpMethod {
        return .get
    }
    
    var path: String {
        return "/top.json"
    }
    
}
