//
//  EndPoints.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation

enum EndPoints {
    
    case events
    case eventDetail(id: String)
    case checkIn
    
    var path: String {
        switch self {
        case .events:
            return "http://5f5a8f24d44d640016169133.mockapi.io/api/events"
        case .checkIn:
            return "http://5f5a8f24d44d640016169133.mockapi.io/api/checkin"
        case .eventDetail(let id):
            return String(format: "http://5f5a8f24d44d640016169133.mockapi.io/api/events/%@", id)
        }
    }
}
