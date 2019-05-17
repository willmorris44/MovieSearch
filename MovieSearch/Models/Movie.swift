//
//  Movie.swift
//  MovieSearch
//
//  Created by Will morris on 5/17/19.
//  Copyright © 2019 devmtn. All rights reserved.
//

import Foundation

struct TopLevelDict: Codable {
    
    let results: [Movie]
}

struct Movie: Codable {
    
    let title: String
    let rating: Double
    let overview: String
    let id: Int
    let image: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case rating = "vote_average"
        case overview
        case id
        case image = "poster_path"
    }
}
