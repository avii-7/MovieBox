//
//  NFEndPointType.swift
//  Netflix
//
//  Created by Arun on 14/04/24.
//

import Foundation

enum NFMovieListEndPoint {
    case popular, nowPlaying, topRated, upcoming, banner
}

extension NFMovieListEndPoint: NFURLConstruct {

    var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .nowPlaying:
            return "movie/now_playing"
        case .topRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
        case .banner:
            return "movie/banner"
        }
    }
    
    // Todo: We need to resolve this concatenation by URLComponents
    var url: URL? {
        URL(string: "\(baseURL + String.URLPathSeparator + version + String.URLPathSeparator + path)")
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .popular:
            return .get
        default:
            return .get
        }
    }
}
