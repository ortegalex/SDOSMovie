//
//  MovieDetail.swift
//  SDOSMovie
//
//  Created by Alex Ortega on 28/12/2019.
//  Copyright © 2019 Alex Ortega. All rights reserved.
//

import Foundation

struct MovieDetail: Codable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let actors: String
    let director: String
    let imdbRating: String
    let plot: String
    let poster: String
    let genre: String
    let runtime: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case actors = "Actors"
        case director = "Director"
        case imdbRating = "imdbRating"
        case plot = "Plot"
        case poster = "Poster"
        case genre = "Genre"
        case runtime = "Runtime"
    }
}
