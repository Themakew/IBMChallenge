//
//  Utils.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation

class Utils {
    public static func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}
