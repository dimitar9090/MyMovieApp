//
//  MovieModel.swift
//  MyMovieApp
//
//  Created by Dimitar Angelov on 15.09.24.
//

import Foundation

// Моделът MovieModel трябва да е достъпен за всички файлове
struct MovieModel: Codable, Identifiable { // Codable включва както Encodable, така и Decodable
    let id: Int
    let title: String
    let vote_average: Double // Рейтинг
    let poster_path: String? // Път към постера
    let overview: String? // Описание на филма
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case vote_average
        case poster_path
        case overview
    }
}
