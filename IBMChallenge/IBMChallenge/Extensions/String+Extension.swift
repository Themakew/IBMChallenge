//
//  String+Extension.swift
//  IBMChallenge
//
//  Created by Ruyther on 02/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation

// MARK: -

extension String {
    
    // MARK: - Internal Methods -
    
    func text(comment: String = "", suffix: String = "") -> String {
        return "\(NSLocalizedString(self, tableName: "IBMChallenge", bundle: Bundle.main, comment: comment))\(suffix)"
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
