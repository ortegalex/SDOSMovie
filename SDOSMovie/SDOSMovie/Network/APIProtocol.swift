//
//  APIProtocol.swift
//  SDOSMovie
//
//  Created by Alex Ortega on 28/12/2019.
//  Copyright © 2019 Alex Ortega. All rights reserved.
//

import Foundation

typealias CompletionClosure = (_ success: Bool, _ object: AnyObject?) -> ()

enum ResponseError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}

enum ResultHandler<T: Codable> {
    case success(data:T)
    case failure(Error)
}

protocol APIProtocol {
}

extension APIProtocol {
    
    static func dataTask(urlRequest: String, method: String, parameters: [String: String]?, completion: @escaping CompletionClosure) {
        
        let urlString = Constants.kBaseURL + urlRequest + "&apiKey=" + Constants.kApiKey
        guard let url = URL(string: urlString) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        if (parameters != nil) {
            let httpBody = try? JSONSerialization.data(withJSONObject: parameters ?? "", options: [])
            request.httpBody = httpBody
        }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request) { (data, response, error) -> Void in
            if let data = data {
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, data as AnyObject)
                } else {
                    completion(false, error as AnyObject)
                }
            }
        }.resume()
    }
}
