//
//  NFUpcomingVM.swift
//  MovieBox
//
//  Created by Arun on 05/05/24.
//

import Foundation

final class NFUpcomingVM {
    
    var movieList = [MovieItem]()
    
    func getUpcomingMovieList() async throws -> MovieResponse? {
        
        let category = NFCategoryListType.Movie(list: NFList.upcoming)
        
        if let response: MovieResponse = try await NFAPICaller.shared.get(category) {
            return response
        }
        return nil
    }
    
    func setMovieItems(_ response: MovieResponse) {
        movieList.append(contentsOf: response.results)
    }
}
