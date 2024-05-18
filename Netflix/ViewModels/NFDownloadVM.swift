//
//  NFDownloadVM.swift
//  Netflix
//
//  Created by Arun on 18/05/24.
//

import Foundation

final class NFDownloadVM {
    
    var movieList = [MovieItem]()
    
    init() {
        fetchAllMovies()
    }

    private func fetchAllMovies() {
        movieList = DataPersistenceManager.shared.getAllMovieItems()
    }
    
    func delete(at indexPath: IndexPath) {
        let itemId = movieList[indexPath.row].id
        movieList.remove(at: indexPath.row)
        DataPersistenceManager.shared.delete(id: itemId)
    }
}
