//
//  CDMovieItem + DomainModel.swift
//  MovieBox
//
//  Created by Arun on 02/06/24.
//

import Foundation

extension CDMovieItem {
    
    func convertToDomainModel() -> MovieItem {
        MovieItem(
            adult: false,
            id: Int(self.id),
            originalLanguage: "",
            originalTitle: "",
            overview: self.overview ?? "",
            popularity: 0,
            backdropPath: self.backdropPath,
            posterPath: self.posterPath,
            releaseDate: "",
            title: self.title ?? "",
            video: false,
            voteAverage: 0,
            voteCount: 0
        )
    }
}
