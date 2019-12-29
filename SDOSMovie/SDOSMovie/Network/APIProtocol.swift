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
    case failure(error:String)
}

protocol APIProtocol {
}

extension APIProtocol {
    
    static func commonCall<T:Codable>(params: [String:String], completionHandler: @escaping (ResultHandler<T>) -> Void) {
        Self.dataTask(method: "GET", parameters: params, completion: { (success, data) in
            if success, let data = data as? Data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: data)
                    completionHandler(.success(data: result))
                } catch {
                    completionHandler(.failure(error: "Error al procesar la respuesta del servidor"))
                }
            } else  {
                if let error = data as? Error {
                    completionHandler(.failure(error: error.localizedDescription))
                } else {
                    completionHandler(.failure(error: "Error en la petición"))
                }
            }
        })
    }
    
    private static func dataTask(method: String, parameters: [String: String]?, completion: @escaping CompletionClosure) {
        
        var components = URLComponents(string: Constants.kBaseURL)!
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: Constants.kApiKey)
        ]
        for (key, value) in parameters ?? [:] {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        var request2 = URLRequest(url: components.url!)
        request2.httpMethod = method
        request2.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: request2) { (data, response, error) -> Void in
            if let data = data {
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, data as AnyObject)
                } else {
                    completion(false, error as AnyObject)
                }
            } else {
                completion(false, error as AnyObject)
            }
        }.resume()
    }
}
