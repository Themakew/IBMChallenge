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
    
    var viewModel: EventsListViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        
        viewModel = EventsListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
}
