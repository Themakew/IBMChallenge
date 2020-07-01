//
//  EventModel.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation

struct EventModel: Codable {
    
    var people: [People]?
    var date: UInt64?
    var description: String?
    var image: String?
    var longitude: Double?
    var latitude: Double?
    var price: Double?
    var title: String?
    var id: String?
    var voucher: [Voucher]?
    
    private enum CodingKeys: String, CodingKey {
        case people
        case date
        case description
        case image
        case longitude
        case latitude
        case price
        case title
        case id
        case voucher = "cupons"
    }
    
    struct People: Codable {
        var id: String?
        var eventId: String?
        var name: String?
        var picture: String?
    }
    
    struct Voucher: Codable {
        var id: String?
        var eventId: String?
        var discount: Int?
    }
}
