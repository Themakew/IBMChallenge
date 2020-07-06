//
//  String+ExtensionTests.swift
//  IBMChallengeTests
//
//  Created by Ruyther on 05/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import XCTest
@testable import IBMChallenge

class StringExtensionTests: XCTestCase {
    func testIsValidEmailTrue() {
        let string = "test@test.com"
        XCTAssertTrue(string.isValidEmail())
    }
    
    func testIsValidEmailFalse() {
        let string = "test"
        XCTAssertFalse(string.isValidEmail())
    }
}
