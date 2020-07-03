//
//  Utils.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import UIKit

class Utils {
    public static func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    public static func alert(_ viewController: UIViewController, title: String? = nil, _ message: String, btnLabel: String? = nil, completion: (() -> ())? = nil, onOK: (() -> ())? = nil) {
            DispatchQueue.main.async {
                let cancelButton = UIAlertAction(title: btnLabel ?? "ok".text(), style: .default, handler: { action in
                    onOK?()
                })
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(cancelButton)

                viewController.present(alert, animated: true, completion: completion)
            }
        }
}
