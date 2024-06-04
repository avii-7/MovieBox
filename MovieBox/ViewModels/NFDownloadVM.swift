//
//  NFDownloadVM.swift
//  MovieBox
//
//  Created by Arun on 18/05/24.
//

import Foundation

final class NFDownloadVM {
    
    var movieList = [MovieItem]()
    
    private let repository: MovieDataRespository
    
    init(repository: MovieDataRespository) {
        self.repository = repository
    }
    
    func fetchAllMovies() {
        movieList.removeAll()
        let movies = repository.getAllMovies()
        movieList.append(contentsOf: movies)
    }
    
    func delete(at index: Int) {
        let id = movieList[index].id
        movieList.remove(at: index)
        repository.delete(by: Int64(id))
    }
}
