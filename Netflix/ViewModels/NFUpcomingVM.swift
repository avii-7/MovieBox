//
//  NFUpcomingVM.swift
//  Netflix
//
//  Created by Arun on 05/05/24.
//

import Foundation

final class NFUpcomingVM {
    
    var movieList = [MovieItem]()
    
    func getMovieList() async throws -> MovieResponse? {
        if let response: MovieResponse = try await NFAPICaller.shared.get(Category.upcoming.endPoint) {
            return response
        }
        return nil
    }
    
    func setMovieItems(_ response: MovieResponse) {
        movieList.append(contentsOf: response.results)
    }
}
