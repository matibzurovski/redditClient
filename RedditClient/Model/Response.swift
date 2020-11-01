//
//  Response.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 01/11/2020.
//

import Foundation

struct ListingResponse: Decodable {
    
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case type = "kind"
    }
}
