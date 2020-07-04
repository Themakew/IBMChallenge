//
//  URLSession+Extension.swift
//  IBMChallenge
//
//  Created by Ruyther on 04/07/20.
//  Copyright © 2020 ruyther. All rights reserved.
//

import Foundation

extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
