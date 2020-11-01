//
//  MockApiCall.swift
//  RedditClientTests
//
//  Created by Matias Bzurovski on 01/11/2020.
//

import Foundation
@testable import RedditClient

class MockApiCall: ApiCall {
    
    var cancelCalled = false
    func cancel() {
        cancelCalled = true
    }
}
