//
//  Listing.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 01/11/2020.
//

import Foundation

struct Listing: Decodable {
    
    /// The listing item that was displayed before this one (if any).
    let previous: String?
    
    /// The listing item that should be displayed after this one (if any).
    let next: String?
    
    /// The posts included on this listing.
    let items: [Post]
    
    enum CodingKeys: String, CodingKey {
        case previous = "before"
        case next = "after"
        case items = "children"
    }
}
