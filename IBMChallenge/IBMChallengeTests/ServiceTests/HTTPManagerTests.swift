//
//  HTTPManagerTests.swift
//  IBMChallengeTests
//
//  Created by Ruyther on 04/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import XCTest
@testable import IBMChallenge

class HTTPManagerTests: XCTestCase {
    
    var httpManager: HTTPManager!
    
    let session = MockURLSession()
    let url = "https://mockurl"
    
    override func setUpWithError() throws {
        super.setUp()
        httpManager = HTTPManager(session: session)
    }
    
    override func tearDownWithError() throws {
        httpManager = nil
        super.tearDown()
    }
    
    func testRequestWithURL() {
        
        let requestURL = URL(string: url)
        
        httpManager.executeRequest(urlString: url) { result in
            // Return data
        }
        
        XCTAssertTrue(session.lastURL == requestURL)
    }
    
    func testRequestResumeCall() throws {
        
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        httpManager.executeRequest(urlString: url) { result in
            // Return data
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testRequestReturnData() throws {
        
        let expectedData = "{}".data(using: .utf8)
        session.nextData = expectedData
        
        var actualData: Data?
        httpManager.executeRequest(urlString: url) { result in
            
            switch result {
            case .failure:
                XCTFail("TestRequestReturnData failured.")
            case .success(let data):
                actualData = data
            }
        }
        
        XCTAssertNotNil(actualData)
    }
    
    func testRequestNotReturnData() throws {
        
        session.nextData = nil
        
        var actualData: Data?
        httpManager.executeRequest(urlString: url) { result in
            
            switch result {
            case .failure:
                actualData = nil
            case .success:
                XCTFail("TestRequestNotReturnData failured.")
            }
        }
        
        XCTAssertNil(actualData)
    }
}
