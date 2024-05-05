//
//  MyEnums.swift
//  Netflix
//
//  Created by Arun on 14/04/24.
//

import Foundation

enum Category: String {
    case banner = "Banner"
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"
    
    var endPoint: NFEndPointType {
        switch self {
        case .banner:
            return .banner
        case .nowPlaying:
            return .nowPlaying
        case .popular:
            return .popular
        case .topRated:
            return .topRated
        case .upcoming:
            return .upcoming
        }
    }
    
    var index: Int {
        switch self {
        case .banner:
            0
        case .nowPlaying:
            1
        case .popular:
            2
        case .topRated:
            3
        case .upcoming:
            4
        }
    }
}

enum Section {
    case banner(viewModel: NFBannerViewModel)
    case nowPlaying(viewModel: NFCategoryViewModel)
    case popular(viewModel: NFCategoryViewModel)
    case topRated(viewModel: NFCategoryViewModel)
    case upcoming(viewModel: NFCategoryViewModel)
    
    var category: Category {
        switch self {
        case .banner:
            return Category.banner
        case .nowPlaying:
            return Category.nowPlaying
        case .popular:
            return Category.popular
        case .topRated:
            return .topRated
        case .upcoming:
            return .upcoming
        }
    }
}
