//
//  PostViewModel.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 01/11/2020.
//

import Foundation

struct PostViewModel {
    let title: String
    let username: String
    let thumbnail: String?
    let fullSizeImage: String?
    let dateTime: Date?
    let comments: Int
    let isUnread: Bool
}
