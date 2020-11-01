//
//  Model+Random.swift
//  RedditClientTests
//
//  Created by Matias Bzurovski on 01/11/2020.
//

import Foundation
@testable import RedditClient

extension PostData {
    static var random: PostData {
        return PostData(id: .random, title: .random, author: .random, thumbnail: .random, fullSizeImage: .random, dateTime: .init(), comments: .random)
    }
}

extension PostViewModel {
    static var randomUnread: PostViewModel {
        return PostViewModel(title: .random, username: .random, thumbnail: .random, fullSizeImage: .random, dateTime: Date(), comments: .random, isUnread: true)
    }
}
