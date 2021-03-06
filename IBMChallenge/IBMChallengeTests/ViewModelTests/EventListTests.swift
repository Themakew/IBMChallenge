//
//  EventListTests.swift
//  IBMChallengeTests
//
//  Created by Ruyther on 04/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import XCTest
@testable import IBMChallenge

class EventListTests: XCTestCase {
    
    let sessionSuccess = MockURLSession()
    
    var viewModel: EventsListViewModel!
    var httpMockDecodingSuccess: HTTPManagerMockSuccessReturnOne!
    var httpMockDecodingError: HTTPManagerMockSuccessReturnTwo!
    var httpMockErrorReturn: HTTPManagerMockErrorReturn!

    override func setUp() {
        super.setUp()

        httpMockDecodingSuccess = HTTPManagerMockSuccessReturnOne(session: sessionSuccess)
        httpMockDecodingError = HTTPManagerMockSuccessReturnTwo(session: sessionSuccess)
        httpMockErrorReturn = HTTPManagerMockErrorReturn(session: sessionSuccess)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testReceiveEventListAndDecode() {
        viewModel = EventsListViewModel(httpManager: httpMockDecodingSuccess)
        
        viewModel.getEvents { result in
            switch result {
            case .failure(let error):
                XCTFail("TestGetEventList failed, error: \(error)")
            case .success(let data):
                XCTAssertNotNil(data)
            }
        }
    }
    
    func testReceiveEventListAndNotDecode() {
        viewModel = EventsListViewModel(httpManager: httpMockDecodingError)
        
        viewModel.getEvents { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success:
                XCTFail("TestGetEventList failed")
            }
        }
    }
    
    func testReceiveEventListAndReturnFailure() {
        viewModel = EventsListViewModel(httpManager: httpMockErrorReturn)
        
        viewModel.getEvents { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success:
                XCTFail("TestGetEventList failed")
            }
        }
    }
}
