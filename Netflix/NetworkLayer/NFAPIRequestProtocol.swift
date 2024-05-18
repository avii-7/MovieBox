//
//  NFEndPoint.swift
//  Netflix
//
//  Created by Arun on 11/05/24.
//

import Foundation

protocol NFAPIRequestProtocol {
    var baseURL: String { get }
    var version: String { get }
    var pathComponents: [String] { get }
    var queryItems: [URLQueryItem]? { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String : String]? { get }
}

extension NFAPIRequestProtocol {
    
    var baseURL: String {
        "https://api.themoviedb.org"
    }
    
    var version: String { "3" }
    
    var queryItems: [URLQueryItem]? { Optional.none }
}
