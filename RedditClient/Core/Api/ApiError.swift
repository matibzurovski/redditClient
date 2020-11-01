//
//  ApiError.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import Foundation

class ApiError: LocalizedError {
    
    fileprivate let message: String
    
    init(message: String) {
        self.message = message
    }
    
    var errorDescription: String? {
        return message
    }
    
}
