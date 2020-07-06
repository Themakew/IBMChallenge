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
    
    func testSendCheckInAndWithSuccess() {
        viewModel = EventDetailViewModel(httpManager: httpMockDecodingSuccess)
        let object = UserDetail(eventId: "", name: "", email: "")
        
        let expectedModel = EventModel(people: [EventModel.People(id: "1",
                                   eventId: "1",
                                   name: "name 1",
                                   picture: "picture 1")],
        date: 1534784400000,
        description: "Description",
        image: "http://lproweb.procempa.com.br/pmpa/prefpoa/seda_news/usu_img/Papel%20de%20Parede.png",
        longitude: -51.2146267,
        latitude: -30.0392981,
        price: 29.99,
        title: "Title",
        id: "1",
        voucher: [EventModel.Voucher(id: "1",
                                     eventId: "1",
                                     discount: 62)])
        
        viewModel.sendUserDetail(request: object) { error in
            XCTAssertTrue(self.viewModel.event.image == expectedModel.image)
        }
    }
    
    func testSendCheckInAndNotDecode() {
        viewModel = EventDetailViewModel(httpManager: httpMockDecodingError)
        let object = UserDetail(eventId: "", name: "", email: "")
        
        viewModel.sendUserDetail(request: object) { error in
            XCTAssertTrue(error?.localizedDescription == "The data couldn’t be read because it isn’t in the correct format.")
        }
    }
    
    func testSendCheckInAndReturnFailure() {
        viewModel = EventDetailViewModel(httpManager: httpMockErrorReturn)
        let object = UserDetail(eventId: "", name: "", email: "")
        
        viewModel.sendUserDetail(request: object) { error in
            XCTAssertTrue(error?.localizedDescription == "The operation couldn’t be completed. (Test error 404.)")
        }
    }
    
    func testBuildEventList() {
        viewModel = EventDetailViewModel(httpManager: httpMockDecodingSuccess)
        
        let object = MapLine(latitude: 10.0, longitude: 10.0)
        let actualList = viewModel.buildEventList(eventList: [object])
        let returnFirstObject = actualList[0] as! MapLine
        
        XCTAssertTrue(returnFirstObject.latitude == object.latitude)
    }
}

