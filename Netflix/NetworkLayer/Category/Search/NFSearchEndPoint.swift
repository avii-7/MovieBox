//
//  NFSearchEndPoint.swift
//  Netflix
//
//  Created by Arun on 11/05/24.
//

import Foundation

enum NFSearchEndPoint {
    case Movie(query: URLQueryItem)
    case TV(query: URLQueryItem)
    case Person(query: URLQueryItem)
    
    var category: NFCategory {
        switch self {
        case .Movie:
            NFCategory.Movie
        case .TV:
            NFCategory.Tv
        case .Person:
            NFCategory.People
        }
    }
}

extension NFSearchEndPoint : NFAPIRequestProtocol {
    
    var pathComponents: [String] {
        let pathComponents = ["search", category.urlPath]
        return pathComponents
    }
    
    var queryItems: [URLQueryItem]? {
        
        switch self {
        case .Movie(let query):
            [query]
        case .TV(let query):
            [query]
        case .Person(let query):
            [query]
        }
    }
    
    var httpMethod: HTTPMethod {
        HTTPMethod.get
    }
    
    var headers: [String : String]? {
        [
            "accept": "application/json",
            "Authorization": "Bearer \(NFConfiguration.accessToken.getValue())"
        ]
    }
}
