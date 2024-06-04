//
//  NFCategoryViewModel.swift
//  MovieBox
//
//  Created by Arun on 14/04/24.
//

import Foundation

final class NFCategoryViewModel {
    
    let name: String
    var items: [MovieItem]
    
    init(name: String, items: [MovieItem]) {
        self.name = name
        self.items = items
    }
    
    func setMovieItems(_ items: [MovieItem]) {
        self.items = items
    }
    
    func addMoviewItems(_ items: [MovieItem]) {
        self.items.append(contentsOf: items)
    }
}
