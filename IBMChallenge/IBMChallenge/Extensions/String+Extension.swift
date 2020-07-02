//
//  String+Extension.swift
//  IBMChallenge
//
//  Created by Ruyther on 02/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation

extension String {
    public func text(comment: String = "", suffix: String = "") -> String {
        return "\(NSLocalizedString(self, tableName: "IBMChallenge", bundle: Bundle.main, comment: comment))\(suffix)"
    }
}
