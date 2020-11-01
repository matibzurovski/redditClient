//
//  ApICall.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 01/11/2020.
//

import Foundation

protocol ApiCall {
    
    func cancel()
}

extension URLSessionDataTask: ApiCall { }
