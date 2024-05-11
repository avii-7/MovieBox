//
//  NFEndPoint.swift
//  Netflix
//
//  Created by Arun on 11/05/24.
//

import Foundation

// Todo: secrets api key placements
enum NFAPIConstants {
    static let API_KEY = "2606c88180e76b70d3fd5037f74403db"
    static let ACESS_TOKEN = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNjA2Yzg4MTgwZTc2YjcwZDNmZDUwMzdmNzQ0MDNkYiIsInN1YiI6IjYxMzBkMzMxMzU3YzAwMDA2NWE2MTk0NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DmPKoOChiE4CWGO9m27kxIIwERDd4-Pu1fAN-V01DIg"
}

// Todo: EndPoint and header should not be in URL Construct, becuase it't not the part of URL rather
// it's part of URLReqest

// Todo: optinal keyword vs default implementaion
protocol NFURLConstruct {
    var baseURL: String { get }
    var version: String { get }
    var path: String { get }
    var url: URL? { get }
    var queryItems: [URLQueryItem]? { get }
}

extension NFURLConstruct {
    
    var baseURL: String {
        "https://api.themoviedb.org"
    }
    
    // MARK: - Optinal
    var queryItems: [URLQueryItem]? { .none }
    
    var version: String { "3" }
    
    var headers: [String : String]? {
        [
            "accept": "application/json",
            "Authorization": "Bearer \(NFAPIConstants.ACESS_TOKEN)"
        ]
    }
}
