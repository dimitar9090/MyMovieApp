//
//  Movie.swift
//  MyMovieApp
//
//  Created by Dimitar Angelov on 12.09.24.
//

//
//  Movie.swift
//  MyMovieApp
//
//  Created by Dimitar Angelov on 11.09.24.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let overview: String
    let vote_average: Double
    let poster_path: String?
}
