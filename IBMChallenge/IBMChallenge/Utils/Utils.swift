//
//  Utils.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import UIKit

// MARK: -

class Utils {
    
    // MARK: - Static Methods -
    
    static func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    static func alert(_ viewController: UIViewController, title: String? = nil, _ message: String, btnLabel: String? = nil, completion: (() -> ())? = nil, onOK: (() -> ())? = nil) {
            DispatchQueue.main.async {
                let cancelButton = UIAlertAction(title: btnLabel ?? "ok".text(), style: .default, handler: { action in
                    onOK?()
                })
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(cancelButton)

                viewController.present(alert, animated: true, completion: completion)
            }
        }
    
    static func setTextFieldAlert(viewController: UIViewController, completionHandler: @escaping(_ nameText: String?, _ emailText: String?) -> Void) {
        
        let alertController = UIAlertController(title: "check_in".text(), message: "check_in_description".text(), preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField {(textField: UITextField!) -> Void in
            textField.placeholder = "name".text()
        }
        
        let cancelAction = UIAlertAction(title: "cancel".text(), style: UIAlertAction.Style.default, handler: nil)
        
        alertController.addTextField {(textField: UITextField!) -> Void in
            textField.placeholder = "email".text()
        }
        
        let saveAction = UIAlertAction(title: "send".text(), style: UIAlertAction.Style.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            
            completionHandler(firstTextField.text, secondTextField.text)
        })

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        viewController.present(alertController, animated: true, completion: nil)
    }
}
