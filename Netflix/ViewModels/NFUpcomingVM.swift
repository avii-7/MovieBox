//
//  NFUpcomingVM.swift
//  Netflix
//
//  Created by Arun on 05/05/24.
//

import Foundation

final class NFUpcomingVM {
    
    var movieList = [MovieItem]()
    
    func getUpcomingMovieList() async throws -> MovieResponse? {
        
        let category = Category.upcoming
        
        let urlRequest = NFRestAPIRequest(
            urlContruct: category.endPoint,
            httpMethod: category.endPoint.httpMethod,
            headers: category.endPoint.headers
        )
        
        guard let urlRequest else { return nil }
        
        if let response: MovieResponse = try await NFAPICaller.shared.get(urlRequest) {
            return response
        }
        return nil
    }
    
    func setMovieItems(_ response: MovieResponse) {
        movieList.append(contentsOf: response.results)
    }
}
