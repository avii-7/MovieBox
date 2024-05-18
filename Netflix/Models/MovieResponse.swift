//
//  MovieResponse.swift
//  Netflix
//
//  Created by Arun on 15/04/24.
//

import Foundation

struct MovieResponse: Decodable {
    
    let page: Int
    let results: [MovieItem]
    
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieItem: Decodable {
    let adult: Bool
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let backdropPath: String?
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension MovieItem {
    static func convert(from model: MovieItemCD) -> MovieItem {
        return MovieItem(
            adult: false,
            id: Int(model.id),
            originalLanguage: "",
            originalTitle: "",
            overview: model.overview ?? "",
            popularity: 0,
            backdropPath: model.backdropPath ?? "",
            posterPath: model.posterPath ?? "",
            releaseDate: "",
            title: model.title ?? "",
            video: false,
            voteAverage: 0,
            voteCount: 0
        )
    }
}
