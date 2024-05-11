//
//  NFSearchViewVM.swift
//  Netflix
//
//  Created by Arun on 09/05/24.
//

import Foundation

final class NFSearchViewVM {
    
    var movieList = [MovieItem]()
    
    func getMovieList(for text: String) async throws -> MovieResponse? {
        
        let queryItem = URLQueryItem(name: "query", value: text)
        
        let searchMovieEndPoint = NFSearchEndPoint.Movie(queries: [queryItem])
        
        let urlRequest = NFRestAPIRequest(
            urlContruct: searchMovieEndPoint,
            httpMethod: searchMovieEndPoint.httpMethod,
            headers: searchMovieEndPoint.headers
        )
        
        guard let urlRequest else { return nil }
        
        if let response: MovieResponse = try await NFAPICaller.shared.get(urlRequest) {
            return response
        }
        
        return nil
    }
    
    func setMovieItems(_ response: MovieResponse) {
        movieList.removeAll()
        if response.results.isEmpty == false {
            movieList.append(contentsOf: response.results)
        }
    }
}
