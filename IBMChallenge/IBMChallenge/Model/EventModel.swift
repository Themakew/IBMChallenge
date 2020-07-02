//
//  EventModel.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation
import CoreLocation

// MARK: -

struct EventModel: Codable {
    
    // MARK: - Properties -
    
    var people: [People]?
    var date: Double?
    var description: String?
    var image: String?
    var longitude: Double?
    var latitude: Double?
    var price: Double?
    var title: String?
    var id: String?
    var voucher: [Voucher]?
    
    var formattedDate: String? { return formatDate(date ?? 0.0) }
    var formattedPrice: String? { return formatPrice(price ?? 0.0) }
    var formattedDescription: String? { return formatDescription(description ?? "") }
    
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
        var discount: Double?
    }
    
    private func formatDate(_ date: Double) -> String {
        let date = Date(timeIntervalSince1970: date)
        return Utils.formatDate(date: date)
    }
    
    private func formatPrice(_ price: Double) -> String {
        return price.monetaryValueWithCurrency ?? "-"
    }
    
    private func formatDescription(_ description: String) -> String {
        return description.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).filter{!$0.isEmpty}.joined(separator: "\n")
    }
}
