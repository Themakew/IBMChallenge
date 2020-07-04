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
    var httpManagerForError: HTTPManager!
    
    let session = MockURLSession()
    let sessionError = MockURLSessionError()
    let url = "https://mockurl"
    let invalidURL = ""
    
    override func setUpWithError() throws {
        super.setUp()
        httpManager = HTTPManager(session: session)
        httpManagerForError = HTTPManager(session: sessionError)
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
    
    func testRequestWithError() throws {
        var actualError: String = ""
        
        session.nextError = NSError(domain: "", code: 404, userInfo: nil) as Error
        
        httpManager.executeRequest(urlString: url) { result in
            switch result {
            case .failure(let error):
                actualError = error.localizedDescription
            case .success:
                XCTFail("TestRequestWithError failed.")
            }
        }
        
        XCTAssertTrue(actualError == "The operation couldn’t be completed. ( error 404.)")
    }
    
    func testRequestEqual() throws {
        let expectedData = "{}".data(using: .utf8)
        session.nextData = expectedData
        
        var actualData: Data?
        httpManager.executeRequest(urlString: url) { result in
            switch result {
            case .failure:
                XCTFail("TestRequestEqual failed.")
            case .success(let data):
                actualData = data
            }
        }
        
        XCTAssertTrue(expectedData == actualData)
    }
    
    func testUserCheckInEqual() throws {
        let objectRequest = UserDetail(eventId: "eventId",
                                       name: "name",
                                       email: "email@email.com")
        let objectEncoded = try JSONEncoder().encode(objectRequest)
        let dictionary = try JSONDecoder().decode([String: String].self, from: JSONEncoder().encode(objectRequest))
        
        session.nextData = objectEncoded
        
        var actualData: Data?
        httpManager.executeRequest(request: dictionary, type: .POST, urlString: url) { result in
            switch result {
            case .failure:
                XCTFail("TestUserCheckInEqual failured.")
            case .success(let data):
                actualData = data
            }
        }
        
        XCTAssertTrue(objectEncoded == actualData)
    }
    
    func testNilRequest() throws {
        session.nextData = nil
        
        var actualData: Data?
        httpManager.executeRequest(urlString: url) { result in
            switch result {
            case .failure:
                actualData = nil
            case .success:
                XCTFail("TestNilRequest failed.")
            }
        }
        
        XCTAssertNil(actualData)
    }
    
    func testRequestWithErrorInReturn() throws {
        let expectedData = "{}".data(using: .utf8)
        sessionError.nextData = expectedData
        
        var actualError: Error?
        httpManager.executeRequest(urlString: url) { result in
            switch result {
            case .failure(let error):
                actualError = error
            case .success:
                XCTFail("TestRequestWithErrorInReturn failed.")
            }
        }
        
        XCTAssertTrue(actualError?.localizedDescription == "Sistema indisponível, tente novamente.")
    }
    
    func testRequestWithInvalidURLRequest() throws {
        var actualError: Error?
        httpManager.executeRequest(urlString: invalidURL) { result in
            switch result {
            case .failure(let error):
                actualError = error
            case .success:
                XCTFail("TestRequestWithInvalidURLRequest failed.")
            }
        }
        
        XCTAssertTrue(actualError?.localizedDescription == "Url inválida, tente novamente.")
    }
}
