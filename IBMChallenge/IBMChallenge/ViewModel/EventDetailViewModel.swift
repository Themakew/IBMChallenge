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
    var httpManagerInstance: HTTPManager?
    
    // MARK: - Init -
    
    init(httpManager: HTTPManager?) {
        if let instance = httpManager {
            httpManagerInstance = instance
        }
    }
    
    // MARK: - Internal Methods -
    
    func getEventDetail(id: String, completion: @escaping(Result<EventModel, Error>) -> Void) {
        httpManagerInstance?.executeRequest(urlString: EndPoints.eventDetail(id: id).path, completionBlock: { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
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
    
    func sendUserDetail(request: UserDetail, completion: @escaping(Error?) -> Void) {
        var dictionary: [String: String] = [:]
        
        do {
            dictionary = try JSONDecoder().decode([String: String].self, from: JSONEncoder().encode(request))
        } catch let error {
            completion(error)
        }
        
        httpManagerInstance?.executeRequest(request: dictionary, type: .POST, urlString: EndPoints.checkIn.path, completionBlock: { result in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    self.event = try decoder.decode(EventModel.self, from: data)
                    completion(nil)
                } catch let error {
                    completion(error)
                }
            }
        })
    }
    
    func buildEventList(eventList: [CellLineModel]) -> [CellLineModel] {
        var list = eventList
        list.append(MapLine(latitude: event.latitude ?? 0.0, longitude: event.longitude ?? 0.0))
        list.append(InfoLine(title: "responsable".text(comment: "", suffix: ":"), imageName: event.people?[0].picture ?? "user", description: event.people?[0].name ?? ""))
        list.append(TwoColumnInfoLine(title: "event".text(comment: "", suffix: ":"), description: event.title ?? ""))
        list.append(TwoColumnInfoLine(title: "description".text(comment: "", suffix: ":"), description: event.description ?? ""))
        list.append(TwoColumnInfoLine(title: "date".text(comment: "", suffix: ":"), description: event.formattedDate ?? ""))
        list.append(TwoColumnInfoLine(title: "price".text(comment: "", suffix: ":"), description: event.formattedPrice ?? ""))
        list.append(TwoColumnInfoLine(title: "vouchers".text(comment: "", suffix: ":"), description: getFinalDiscountString(discountList: event.voucher ?? [])))
        
        return list
    }
    
    private func getFinalDiscountString(discountList: [EventModel.Voucher]) -> String {
        var finalDiscountString: String = ""
        for price in (event.voucher ?? []) {
            finalDiscountString += "\(price.discount?.monetaryValueWithCurrency ?? "")\n"
        }
        
        return finalDiscountString
    }
}
