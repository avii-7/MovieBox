//
//  ImageRequestBuilder.swift
//  Netflix
//
//  Created by Arun on 05/05/24.
//

import Foundation
// https://image.tmdb.org/t/p/w300/nVOZuxRiBygJ3VmXc9QcDGZfHzD.jpg

struct ImageRequestBuilder {
    
    static let baseUrl = "https://image.tmdb.org/t/p"
    
    static let width = 300
    
    static func get(for path: String) -> String {
        return "\(baseUrl)/w\(width)/\(path)"
    }
}
