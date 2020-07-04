//
//  EventModelTests.swift
//  IBMChallengeTests
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import XCTest
@testable import IBMChallenge

class IBMChallengeTests: XCTestCase {

    var model: EventModel!
    var modelResponse: [EventModel] = []
    
    override func setUpWithError() throws {
        super.setUp()
        
        model = EventModel()
        model.date = 1534784400000
        model.price = 59.99
    }

    override func tearDownWithError() throws {
        model = nil
        super.tearDown()
    }
    
    func testFormatDate() {
        
        let formattedDate = model.formattedDate
        
        XCTAssertEqual(formattedDate, "20/05/50605")
    }
    
    func testFormatPrice() {
        
        let formattedPrice = model.formattedPrice
        
        XCTAssertEqual(formattedPrice, "R$\u{00a0}59,99")
    }

    func testJSONParsing() throws {
        
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "mock", withExtension: "json") else {
            XCTFail("Missing file: mock.json")
            return
        }
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        do {
            modelResponse = try decoder.decode([EventModel].self, from: data)
        } catch let error {
            XCTFail("Decode error: \(error)")
        }
        
        XCTAssertEqual(modelResponse.count, 3)
    }
}