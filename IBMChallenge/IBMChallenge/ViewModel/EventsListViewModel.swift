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
    
    // MARK: - Init -
    
    init(model: [EventModel]? = nil) {
        if let inputModel = model {
            events = inputModel
        }
    }

    // MARK: - Internal Methods -
    
    func getEvents(completion: @escaping (Result<[EventModel], Error>) -> Void) {
        HTTPManager.shared.executeRequest(urlString: EndPoints.events.path, completionBlock: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print ("failure".text(), error)
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
