//
//  EventTableViewCellViewModel.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation
import CoreLocation

// MARK: -

class EventTableViewCellViewModel {
    
    // MARK: - Properties -
    
    private var location = CLLocation()
    private var geoCoder = CLGeocoder()
    
    // MARK: - Internal Methods -
    
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
    
    func getLocationName(latitude: Double, longitude: Double, completion: @escaping (String, Error?) -> Void) {
        
        let location = getLocation(latitude: latitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error == nil {
                placemarks?.forEach({ (placemark) in
                    if let city = placemark.locality {
                        completion(city, nil)
                    }
                })
            } else {
                completion("", error)
            }
        }
    }
    
    // MARK: - Private Methods -
    
    private func getLocation(latitude: Double, longitude: Double) -> CLLocation {
        location = CLLocation(latitude: latitude, longitude: longitude)
        return location
    }
}
