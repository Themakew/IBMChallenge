//
//  Utils.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import UIKit

// MARK: -

enum StorageType {
    case fileSystem
}

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
    
    static func saveImageInDevice(image: UIImage, imageName: String, storageType: StorageType) {
        if let pngRepresentation = image.pngData() {
            switch storageType {
            case .fileSystem:
                if !FileManager().fileExists(atPath: self.getFilePath(imageName: imageName)?.path ?? "") {
                    if let filePath = self.getFilePath(imageName: imageName) {
                        do {
                            try pngRepresentation.write(to: filePath,
                                                        options: .atomic)
                            print("Image \(imageName).png saved.")
                            print(filePath)
                        } catch let error {
                            print("Saving file resulted in error: ", error)
                        }
                    }
                }
            }
        }
    }

    static func getImageFromDevice(imageName: String, storageType: StorageType) -> UIImage? {
        switch storageType {
        case .fileSystem:
            if let filePath = getFilePath(imageName: imageName),
                let fileData = FileManager.default.contents(atPath: filePath.path),
                let image = UIImage(data: fileData) {
                return image
            }
        }
        
        return UIImage(named: "empty_image")
    }
    
    static func getFilePath(imageName: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        let filename = imageName + ".png"
        
        return documentURL.appendingPathComponent(filename)
    }
}
