//
//  ApiRequest.swift
//  RedditClient
//
//  Created by Matias Bzurovski on 31/10/2020.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol ApiRequest: Encodable {
    var httpMethod: HttpMethod { get }
    var path: String { get }
}
