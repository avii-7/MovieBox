//
//  NFList.swift
//  MovieBox
//
//  Created by Arun on 12/05/24.
//

import Foundation

enum NFList {
    case banner
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    var index: Int {
        switch self {
        case .banner: 0
        case .nowPlaying: 1
        case .popular: 2
        case .topRated: 3
        case .upcoming: 4
        }
    }
    
    var name: String {
        switch self {
        case .banner:
            "Banner"
        case .nowPlaying:
            "Now Playing"
        case .popular:
            "Popular"
        case .topRated:
            "Top Rated"
        case .upcoming:
            "Upcoming"
        }
    }
}
