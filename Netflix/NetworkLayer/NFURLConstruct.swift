//
//  NFEndPoint.swift
//  Netflix
//
//  Created by Arun on 11/05/24.
//

import Foundation

enum NFAPIConstants {
    static let API_KEY = "2606c88180e76b70d3fd5037f74403db"
    static let ACESS_TOKEN = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNjA2Yzg4MTgwZTc2YjcwZDNmZDUwMzdmNzQ0MDNkYiIsInN1YiI6IjYxMzBkMzMxMzU3YzAwMDA2NWE2MTk0NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DmPKoOChiE4CWGO9m27kxIIwERDd4-Pu1fAN-V01DIg"
}

protocol NFURLConstruct {
    var baseURL: String { get }
    var version: String { get }
    var path: String { get }
    var url: URL? { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
    
}


extension NFURLConstruct {
    var baseURL: String {
        "https://api.themoviedb.org"
    }
    
    var version: String { "3" }
    
    var pathSeparator: String { "/" }
    
    var headers: [String : String]? {
        [
            "accept": "application/json",
            "Authorization": "Bearer \(NFAPIConstants.ACESS_TOKEN)"
        ]
    }
}
