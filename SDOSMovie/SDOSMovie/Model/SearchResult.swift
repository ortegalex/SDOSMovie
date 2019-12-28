//
//  SearchResult.swift
//  SDOSMovie
//
//  Created by Alex Ortega on 28/12/2019.
//  Copyright © 2019 Alex Ortega. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let response : String
    let movies: [Movie]?
    let totalResults : String?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case movies = "Search"
        case totalResults = "TotalResults"
        case error = "Error"
    }
}
