//
//  EventsListViewModel.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation

// MARK: -

class EventsListViewModel {
    
    // MARK: - Properties -
    
    var events = [EventModel]()
    var httpManagerInstance: HTTPManager?
    
    // MARK: - Init -
    
    init(httpManager: HTTPManager?) {
        if let instance = httpManager {
            httpManagerInstance = instance
        }
    }

    // MARK: - Internal Methods -
    
    func getEvents(completion: @escaping (Result<[EventModel], Error>) -> Void) {
        httpManagerInstance?.executeRequest(urlString: EndPoints.events.path, completionBlock: { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    self.events = try decoder.decode([EventModel].self, from: data)
                    completion(.success(try decoder.decode([EventModel].self, from: data)))
                } catch let error {
                    completion(.failure(error))
                }
            }
        })
    }
}
