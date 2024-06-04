//
//  NFCategory+URLPath.swift
//  MovieBox
//
//  Created by Arun on 12/05/24.
//

import Foundation

extension NFCategory {
    
    var urlPath: String {
        switch self {
        case .Movie:
            "movie"
        case .Tv:
            "tv"
        case .People:
            "person"
        }
    }
}
