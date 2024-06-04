//
//  NFList+EndPoint.swift
//  MovieBox
//
//  Created by Arun on 12/05/24.
//

import Foundation

extension NFList {
    var urlPath: String {
        switch self {
        case .nowPlaying:
            "now_playing"
        case .popular:
            "popular"
        case .topRated:
            "top_rated"
        case .upcoming:
            "upcoming"
        case .banner:
            ""
        }
    }
}
