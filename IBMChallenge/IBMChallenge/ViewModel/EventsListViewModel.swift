//
//  EventsListViewModel.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation
import CoreLocation

class EventsListViewModel {
    
    private var location = CLLocation()
    private var geoCoder = CLGeocoder()
    
    var events = [EventModel]()
    
    init(model: [EventModel]? = nil) {
        if let inputModel = model {
            events = inputModel
        }
    }
}

extension EventsListViewModel {
    func getEvents(completion: @escaping (Result<[EventModel], Error>) -> Void) {
        HTTPManager.shared.get(urlString: EndPoints.events.path, completionBlock: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let data) :
                let decoder = JSONDecoder()
                do
                {
                    self.events = try decoder.decode([EventModel].self, from: data)
                    completion(.success(try decoder.decode([EventModel].self, from: data)))
                } catch let error {
                    completion(.failure(error))
                }
            }
        })
    }

    func getLocationName(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (String, Error?) -> Void) {
        
        let location = getLocation(latitude: latitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error == nil {
                placemarks?.forEach({ (placemark) in
                    if let city = placemark.locality {
                        completion(city, nil)
                    }
                })
            }
            completion("", error)
        }
    }
    
    private func getLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> CLLocation {
        location = CLLocation(latitude: latitude, longitude: longitude)
        return location
    }
}
