//
//  MyEnums.swift
//  Netflix
//
//  Created by Arun on 14/04/24.
//

import Foundation

enum Section {
    case banner(viewModel: NFBannerViewModel)
    case nowPlaying(viewModel: NFCategoryViewModel)
    case popular(viewModel: NFCategoryViewModel)
    case topRated(viewModel: NFCategoryViewModel)
    case upcoming(viewModel: NFCategoryViewModel)
    
    var category: NFList {
        switch self {
        case .banner:
            return NFList.banner
        case .nowPlaying:
            return NFList.nowPlaying
        case .popular:
            return NFList.popular
        case .topRated:
            return NFList.topRated
        case .upcoming:
            return NFList.upcoming
        }
    }
}
