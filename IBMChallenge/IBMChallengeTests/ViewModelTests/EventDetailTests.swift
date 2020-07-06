//
//  EventDetailTests.swift
//  IBMChallengeTests
//
//  Created by Ruyther on 05/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import XCTest
@testable import IBMChallenge

class EventDetailTests: XCTestCase {
    
    let sessionSuccess = MockURLSession()
    
    var viewModel: EventDetailViewModel!
    var httpMockDecodingSuccess: HTTPManagerMockSuccessReturnSingleObject!
    var httpMockDecodingError: HTTPManagerMockSuccessReturnTwo!
    var httpMockErrorReturn: HTTPManagerMockErrorReturn!

    override func setUp() {
        super.setUp()

        httpMockDecodingSuccess = HTTPManagerMockSuccessReturnSingleObject(session: sessionSuccess)
        httpMockDecodingError = HTTPManagerMockSuccessReturnTwo(session: sessionSuccess)
        httpMockErrorReturn = HTTPManagerMockErrorReturn(session: sessionSuccess)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testReceiveEventDetailAndDecode() {
        viewModel = EventDetailViewModel(httpManager: httpMockDecodingSuccess)
        
        viewModel.getEventDetail(id: "1") { result in
            switch result {
            case .failure(let error):
                XCTFail("TestGetEventList failed, error: \(error)")
            case .success(let data):
                XCTAssertNotNil(data)
            }
        }
    }
    
    func testReceiveEventDetailAndNotDecode() {
        viewModel = EventDetailViewModel(httpManager: httpMockDecodingError)
        
        viewModel.getEventDetail(id: "1") { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success:
                XCTFail("TestGetEventList failed")
            }
        }
    }
    
    func testReceiveEventDetailAndReturnFailure() {
        viewModel = EventDetailViewModel(httpManager: httpMockErrorReturn)
        
        viewModel.getEventDetail(id: "1") { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success:
                XCTFail("TestGetEventList failed")
            }
        }
    }
}

