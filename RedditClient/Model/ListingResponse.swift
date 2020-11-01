//
//  ListingResponse.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 01/11/2020.
//

import Foundation

struct ListingResponse: Decodable {
    
    let type: String
    let data: Listing
    
    enum CodingKeys: String, CodingKey {
        case type = "kind"
        case data
    }
}
