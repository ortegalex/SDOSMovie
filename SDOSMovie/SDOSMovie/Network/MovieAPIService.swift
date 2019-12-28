//
//  MovieAPIService.swift
//  SDOSMovie
//
//  Created by Alex Ortega on 28/12/2019.
//  Copyright © 2019 Alex Ortega. All rights reserved.
//

import Foundation


struct MovieAPIService: APIProtocol {
    
    static func searchMovies<T:Codable>(searchText: String, page: Int, completionHandler: @escaping (ResultHandler<T>) -> Void) {
        let params = ["s":searchText, "page": String(page)]
        Self.dataTask(method: "GET", parameters: params, completion: { (success, data) in
            if success, let data = data as? Data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: data)
                    completionHandler(.success(data: result))
                } catch {
                    print(error.localizedDescription)
                    completionHandler(.failure(ResponseError.objectSerialization(reason: "Error al parsear JSON")))
                }
            } else  {
                completionHandler(.failure(ResponseError.urlError(reason: "Error connection")) )
            }
        })
    }
    
    static func getMovie<T:Codable>(byId: String, completionHandler: @escaping (ResultHandler<T>) -> Void) {
        let params = ["i":byId]
        Self.dataTask(method: "GET", parameters: params, completion: { (success, data) in
            if success, let data = data as? Data {
                let decoder = JSONDecoder()
                do {
                    let movies = try decoder.decode(T.self, from: data)
                    completionHandler(.success(data: movies))
                } catch {
                    print(error.localizedDescription)
                    completionHandler(.failure(ResponseError.objectSerialization(reason: "Error al parsear JSON")))
                }
            } else  {
                completionHandler(.failure(ResponseError.urlError(reason: "Error connection")) )
            }
        })
    }
    
    
}
