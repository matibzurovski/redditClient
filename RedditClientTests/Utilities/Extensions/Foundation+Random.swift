//
//  Foundation+Random.swift
//  RedditClientTests
//
//  Created by Matias Bzurovski on 01/11/2020.
//

import Foundation

extension String {
    static var random: String {
        return UUID().uuidString
    }
}

extension Int {
    static var random: Int {
        return Int(arc4random())
    }
}

extension NSError {
    static var random: Error {
        return NSError(domain: .random, code: .random, userInfo: nil)
    }
}
