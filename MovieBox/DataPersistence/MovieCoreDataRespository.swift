//
//  MovieDataRespository.swift
//  MovieBox
//
//  Created by Arun on 02/06/24.
//

import Foundation

protocol MovieDataRespository {
    func save(_ movie: MovieItem) -> Bool
   @discardableResult func delete(by id: Int64) -> Bool
    func getAllMovies() -> [MovieItem]
    func get(by id: Int64) -> MovieItem?
}

final class MovieCoreDataRespository: MovieDataRespository {
    
    func save(_ movie: MovieItem) -> Bool {
        
        if let _ : CDMovieItem = get(by: Int64(movie.id)) {
            return false
        }
        
        let context = PersistenceManager.shared.context
        
        let movieItemCD = CDMovieItem(context: context)
        movieItemCD.id = Int64(movie.id)
        movieItemCD.backdropPath = movie.backdropPath
        movieItemCD.overview = movie.overview
        movieItemCD.posterPath = movie.posterPath
        movieItemCD.title = movie.title
        
        PersistenceManager.shared.saveContext()
        return true
    }
    
    func delete(by id: Int64) -> Bool {
        let context = PersistenceManager.shared.context
        
        if let result: CDMovieItem = get(by: id) {
            context.delete(result)

            PersistenceManager.shared.saveContext()
            return true
        }
        
        return false
    }
    
    func getAllMovies() -> [MovieItem] {
        
        let context = PersistenceManager.shared.context
        
        let fetchRequest = CDMovieItem.fetchRequest()
        
        var models = [MovieItem]()
        
        do {
            let result = try context.fetch(fetchRequest)
            
            for item in result {
                models.append(item.convertToDomainModel())
            }
            
        } catch {
            print(error)
        }
        
        return models
    }
    
    func get(by id: Int64) -> MovieItem? {
        get(by: id)?.convertToDomainModel()
    }
    
    private func get(by id: Int64) -> CDMovieItem? {
        let fetchRequest = CDMovieItem.fetchRequest()
        
        let predicate = NSPredicate(format: "id==%d", id as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            if let result = try PersistenceManager.shared.context.fetch(fetchRequest).first {
                return result
            }
        } catch {
            print(error)
        }
        return nil
    }
}
