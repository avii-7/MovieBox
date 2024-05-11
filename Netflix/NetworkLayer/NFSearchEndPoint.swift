//
//  NFSearchEndPoint.swift
//  Netflix
//
//  Created by Arun on 11/05/24.
//

import Foundation

enum NFSearchEndPoint {
    case Movie(queries: [URLQueryItem])
}

extension NFSearchEndPoint: NFURLConstruct {
    
    var path: String {
        switch self {
        case .Movie:
            "search/movie"
        }
    }
    
    var url: URL? {
        URL(string: "\(baseURL + String.URLPathSeparator + version + String.URLPathSeparator + path)")
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .Movie:
            return HTTPMethod.get
        }
    }
    
    var queryItems: [URLQueryItem]? {
        if case NFSearchEndPoint.Movie(let queries) = self {
            return queries
        }
        return .none
    }
}
