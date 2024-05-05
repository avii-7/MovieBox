//
//  NFEndPointType.swift
//  Netflix
//
//  Created by Arun on 14/04/24.
//

import Foundation

enum NFAPIConstants {
    static let API_KEY = "2606c88180e76b70d3fd5037f74403db"
    static let ACESS_TOKEN = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNjA2Yzg4MTgwZTc2YjcwZDNmZDUwMzdmNzQ0MDNkYiIsInN1YiI6IjYxMzBkMzMxMzU3YzAwMDA2NWE2MTk0NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DmPKoOChiE4CWGO9m27kxIIwERDd4-Pu1fAN-V01DIg"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPoint {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
}

enum NFEndPointType {
    case popular, nowPlaying, topRated ,upcoming, banner
}

extension NFEndPointType: EndPoint {
    
    var path: String {
        switch self {
        case .popular:
            return "popular"
        case .nowPlaying:
            return "now_playing"
        case .topRated:
            return "top_rated"
        case .upcoming:
            return "upcoming"
        case .banner:
            return "banner"
        }
    }
    
    var baseURL: String {
        "https://api.themoviedb.org/3/movie/"
    }
    
    var url: URL? {
        .init(string: "\(baseURL)\(path)")
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .popular:
            return .get
        default:
            return .get
        }
    }
    
    var headers: [String : String]? {
        [
            "accept": "application/json",
            "Authorization": "Bearer \(NFAPIConstants.ACESS_TOKEN)"
        ]
    }
}
