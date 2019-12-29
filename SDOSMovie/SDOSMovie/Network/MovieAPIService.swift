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
        Self.commonCall(params: params) { (result) in
            completionHandler(result)
        }
    }
    
    static func getMovie<T:Codable>(byId: String, completionHandler: @escaping (ResultHandler<T>) -> Void) {
        let params = ["i":byId]
        Self.commonCall(params: params) { (result) in
            completionHandler(result)
        }
    }
    
}
