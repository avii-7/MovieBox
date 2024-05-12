//
//  NFCategory.swift
//  Netflix
//
//  Created by Arun on 12/05/24.
//

import Foundation

enum NFCategory {
    case Movie
    case Tv
    case People
    
    func getCategoryList(list: NFList) -> NFCategoryListType {
        switch self {
        case .Movie:
            NFCategoryListType.Movie(list: list)
        case .Tv:
            NFCategoryListType.People(list: list)
        case .People:
            NFCategoryListType.TV(list: list)
        }
    }
}
