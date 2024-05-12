//
//  NFDetailEndPoint.swift
//  Netflix
//
//  Created by Arun on 12/05/24.
//

import Foundation

enum NFCategoryVideEndPoint {
    case Movie(id: Int)
    case TV(id: Int)
    case People(id: Int)
}

extension NFCategoryVideEndPoint: NFAPIRequestProtocol {
    
    var pathComponents: [String] {
        
        let category: NFCategory
        var categoryId: Int

        switch self {
        case .Movie(let id):
            category = NFCategory.Movie
            categoryId = id
        case .TV(let id):
            category = NFCategory.Tv
            categoryId = id
        case .People(let id):
            category = NFCategory.People
            categoryId = id
        }
        
        return [category.urlPath, "\(categoryId)", "videos"]
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var headers: [String : String]? {
        [
            "accept": "application/json",
            "Authorization": "Bearer \(NFAPIConstants.ACESS_TOKEN)"
        ]
    }
}
