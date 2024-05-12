//
//  NFEndPoint.swift
//  Netflix
//
//  Created by Arun on 11/05/24.
//

import Foundation

// https://api.themoviedb.org/3/movie/{movie_id}/videos

// Todo: secrets api key placements
enum NFAPIConstants {
    static let API_KEY = "2606c88180e76b70d3fd5037f74403db"
    static let ACESS_TOKEN = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNjA2Yzg4MTgwZTc2YjcwZDNmZDUwMzdmNzQ0MDNkYiIsInN1YiI6IjYxMzBkMzMxMzU3YzAwMDA2NWE2MTk0NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DmPKoOChiE4CWGO9m27kxIIwERDd4-Pu1fAN-V01DIg"
    static let Google_API_KEY = "AIzaSyBzmwinCF-PHKRJl7GJg2YrABT6CR4RHRo"
}

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
