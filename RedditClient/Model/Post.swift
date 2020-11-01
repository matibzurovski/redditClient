//
//  Post.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 01/11/2020.
//

import Foundation

struct Post: Decodable {
    
    let type: String
    let data: PostData
    
    enum CodingKeys: String, CodingKey {
        case type = "kind"
        case data
    }
    
}
