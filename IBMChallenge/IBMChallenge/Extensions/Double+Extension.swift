//
//  Double+Extension.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation

extension Double {
    var monetaryValueWithCurrency: String? {
        let formatter = getMonetaryFormatter()
        formatter.currencySymbol = "R$"
        let result = formatter.string(from: self as NSNumber)
        return result
    }
    
    private func getMonetaryFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }
}
