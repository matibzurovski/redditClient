//
//  PostData.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 01/11/2020.
//

import Foundation

struct PostData: Decodable {
    
    let id: String
    let title: String
    let author: String
    let thumbnail: String?
    let fullSizeImage: String?
    let dateTime: Date
    let comments: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case thumbnail
        case fullSizeImage = "url"
        case dateTime = "created_utc"
        case comments = "num_comments"
    }
}
