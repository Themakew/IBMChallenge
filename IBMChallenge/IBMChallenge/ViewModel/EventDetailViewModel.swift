//
//  EventDetailViewModel.swift
//  IBMChallenge
//
//  Created by Ruyther on 02/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation

// MARK: -

class EventDetailViewModel {
    
    // MARK: - Properties -
    
    var event = EventModel()
    
    // MARK: - Init -
    
    init(model: EventModel? = nil) {
        if let inputModel = model {
            event = inputModel
        }
    }
    
    // MARK: - Internal Methods -
    
    func getEventDetail(id: String, completion: @escaping (Result<EventModel, Error>) -> Void) {
        HTTPManager.shared.get(urlString: EndPoints.eventDetail(id: id).path, completionBlock: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    self.event = try decoder.decode(EventModel.self, from: data)
                    completion(.success(try decoder.decode(EventModel.self, from: data)))
                } catch {
                    completion(.failure(error))
                }
            }
        })
    }
    
    func buildEventList(eventList: [CellLineModel]) -> [CellLineModel] {
        var list = eventList
        list.append(MapLine(latitude: event.latitude ?? 0.0, longitude: event.longitude ?? 0.0))
        list.append(InfoLine(title: "Responsável:", imageName: event.people?[0].picture ?? "user", description: event.people?[0].name ?? ""))
        list.append(TwoColumnInfoLine(title: "Evento:", description: event.title ?? ""))
        list.append(TwoColumnInfoLine(title: "Descrição:", description: event.description ?? ""))
        list.append(TwoColumnInfoLine(title: "Data:", description: event.formattedDate ?? ""))
        list.append(TwoColumnInfoLine(title: "Preço:", description: event.formattedPrice ?? ""))
        list.append(TwoColumnInfoLine(title: "Cupons:", description: event.voucher?[0].discount?.monetaryValueWithCurrency ?? ""))
        
        return list
    }
}
