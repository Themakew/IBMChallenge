//
//  HTTPManager.swift
//  IBMChallenge
//
//  Created by Ruyther on 01/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation

// MARK: - Enum -

enum HTTPError: Error {
    case invalidURL
    case invalidResponse
}

enum HTTPMethod: String {
    case POST = "POST"
    case GET = "GET"
}

// MARK: - LocalizedError -

extension HTTPError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "service_url_error".text()
        case .invalidResponse:
            return "service_error".text()
        }
    }
}

// MARK: -

class HTTPManager {
    
    // MARK: - Properties -
    
    static let shared: HTTPManager = HTTPManager()
    
    // MARK: - Internal Methods -
    
    func executeRequest(request: [String: String] = [:], type: HTTPMethod = .GET, urlString: String, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionBlock(.failure(HTTPError.invalidURL))
            return
        }
        
        let requestDictionary = createRequest(request: request, type: type, url: url)
        
        let task = URLSession.shared.dataTask(with: requestDictionary) { data, response, error in
            guard error == nil else {
                completionBlock(.failure(error!))
                return
            }

            guard let responseData = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    completionBlock(.failure(HTTPError.invalidResponse))
                    return
            }

            completionBlock(.success(responseData))
        }
        task.resume()
    }
    
    private func createRequest(request: [String: String], type: HTTPMethod, url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = type.rawValue
        
        guard type == .POST, let httpBody = try? JSONSerialization.data(withJSONObject: request, options: []) else {
            return urlRequest
        }
        
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = httpBody
        return urlRequest
    }
}
