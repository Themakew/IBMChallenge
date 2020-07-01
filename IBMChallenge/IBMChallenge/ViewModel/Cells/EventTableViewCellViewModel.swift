//
//  EventTableViewCellViewModel.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation

class EventTableViewCellViewModel {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if error == nil {
                        completion(data, response, nil)
                    } else {
                        completion(data, response, error)
                    }
                } else {
                    completion(data, response, NSError(domain: "", code: httpResponse.statusCode, userInfo: nil))
                }
            }  
        }.resume()
    }
}
