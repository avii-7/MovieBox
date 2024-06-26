//
//  DataPersistenceManager.swift
//  MovieBox
//
//  Created by Arun on 18/05/24.
//

import Foundation
import CoreData

final class PersistenceManager {
    
    private init() { }
    
    static let shared = PersistenceManager()
    
    lazy var context = persistentContainer.viewContext
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieBoxCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                
            }
        }
    }
}
