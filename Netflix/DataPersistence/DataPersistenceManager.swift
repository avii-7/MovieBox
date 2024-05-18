//
//  DataPersistenceManager.swift
//  Netflix
//
//  Created by Arun on 18/05/24.
//

import Foundation
import CoreData

final class DataPersistenceManager {
    
    private init() { }
    
    static let shared = DataPersistenceManager()
    
    private lazy var context = persistentContainer.viewContext
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NetflixCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func save(model movie: MovieItem) -> Bool {
        
        if let item = getMovieItem(by: movie.id) {
            return false
        }
        
        let movieItemCD = MovieItemCD(context: context)
        movieItemCD.id = Int64(movie.id)
        movieItemCD.backdropPath = movie.backdropPath
        movieItemCD.overview = movie.overview
        movieItemCD.posterPath = movie.posterPath
        movieItemCD.title = movie.title
    
        saveContext()
        return true
    }
    
    func getAllMovieItems() -> [MovieItem] {
        
        let fetchRequest = MovieItemCD.fetchRequest()
        
        do {
            let result = try context.fetch(fetchRequest)
            
            var models = [MovieItem]()
            
            for item in result {
                models.append(MovieItem.convert(from: item))
            }
            
            return models
        } catch {
            print(error)
            return []
        }
    }
    
    func delete(id: Int) {
        do {
            if let result = getMovieItem(by: id) {
                context.delete(result)
                try context.save()
            }
        }
        catch {
            print(error)
        }
    }
    
    private func getMovieItem(by id: Int) -> MovieItemCD? {
        
        let fetchRequest = MovieItemCD.fetchRequest()

        let predicate = NSPredicate(format: "id==%d", id as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            if let result = try context.fetch(fetchRequest).first {
                return result
            }
        }
        catch {
            print(error)
        }
        
        return nil
    }
}
