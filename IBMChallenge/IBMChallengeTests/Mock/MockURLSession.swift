//
//  MockURLSession.swift
//  IBMChallengeTests
//
//  Created by Foton on 04/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation
@testable import IBMChallenge

class MockURLSession: URLSessionProtocol {
    
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    var lastURL: URL?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        return nextDataTask
    }
}

class MockURLSessionError: MockURLSession {
    func errorHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 404, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        completionHandler(nextData, errorHttpURLResponse(request: request), nextError)
        return nextDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    
    private(set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
