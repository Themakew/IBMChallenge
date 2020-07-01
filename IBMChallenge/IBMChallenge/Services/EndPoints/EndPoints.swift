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
    
    var path: String {
        switch self {
        case .events:
            return "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events"
        case .eventDetail(let id):
            return String(format: "http://5b840ba5db24a100142dcd8c.mockapi.io/api/events/%@", id)
        }
    }
}
