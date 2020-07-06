//
//  HTTPManagerMock.swift
//  IBMChallengeTests
//
//  Created by Ruyther on 05/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation
@testable import IBMChallenge

// MARK: - (Success Returning) Success Decoding Scenerio -

class HTTPManagerMockSuccessReturnOne: HTTPManager {
    
    override func executeRequest(request: [String: String] = [:], type: HTTPMethod = .GET, urlString: String, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        
        var data = Data()
        let model = EventModel(people: [EventModel.People(id: "1",
                                   eventId: "1",
                                   name: "name 1",
                                   picture: "picture 1")],
        date: 1534784400000,
        description: "Description",
        image: "http://lproweb.procempa.com.br/pmpa/prefpoa/seda_news/usu_img/Papel%20de%20Parede.png",
        longitude: -51.2146267,
        latitude: -30.0392981,
        price: 29.99,
        title: "Title",
        id: "1",
        voucher: [EventModel.Voucher(id: "1",
                                     eventId: "1",
                                     discount: 62)])
        
        do {
            data = try JSONEncoder().encode([model])
        } catch {
            print("Decoding erro in HTTPManagerMock")
        }
        
        completionBlock(.success(data))
    }
}

// MARK: - (Success Returning) Success Decoding Scenerio in Detail -

class HTTPManagerMockSuccessReturnSingleObject: HTTPManager {
    
    override func executeRequest(request: [String: String] = [:], type: HTTPMethod = .GET, urlString: String, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        
        var data = Data()
        let model = EventModel(people: [EventModel.People(id: "1",
                                   eventId: "1",
                                   name: "name 1",
                                   picture: "picture 1")],
        date: 1534784400000,
        description: "Description",
        image: "http://lproweb.procempa.com.br/pmpa/prefpoa/seda_news/usu_img/Papel%20de%20Parede.png",
        longitude: -51.2146267,
        latitude: -30.0392981,
        price: 29.99,
        title: "Title",
        id: "1",
        voucher: [EventModel.Voucher(id: "1",
                                     eventId: "1",
                                     discount: 62)])
        
        do {
            data = try JSONEncoder().encode(model)
        } catch {
            print("Decoding erro in HTTPManagerMock")
        }
        
        completionBlock(.success(data))
    }
}

// MARK: - (Success Returning) Error Decoding Scenerio -

class HTTPManagerMockSuccessReturnTwo: HTTPManager {
    override func executeRequest(request: [String: String] = [:], type: HTTPMethod = .GET, urlString: String, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        
        let data: Data! = "[{Test:Test}]".data(using:.utf8)
        completionBlock(.success(data))
    }
}

// MARK: - Error Returning -

class HTTPManagerMockErrorReturn: HTTPManager {
    override func executeRequest(request: [String: String] = [:], type: HTTPMethod = .GET, urlString: String, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        completionBlock(.failure(NSError(domain: "Test", code: 404, userInfo: nil)))
    }
}
