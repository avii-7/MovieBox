//
//  NFCategoryList.swift
//  MovieBox
//
//  Created by Arun on 12/05/24.
//

import Foundation

enum NFCategoryListType {
    case Movie(list: NFList)
    case TV(list: NFList)
    case People(list: NFList)
}

extension NFCategoryListType: NFAPIRequestProtocol {
    
    var pathComponents: [String] {
        switch self {
        case .Movie(let list):
            [NFCategory.Movie.urlPath, list.urlPath]
        case .TV(let list):
            [NFCategory.Tv.urlPath, list.urlPath]
        case .People(let list):
            [NFCategory.People.urlPath, list.urlPath]
        }
    }
    
    var httpMethod: HTTPMethod {
        HTTPMethod.get
    }
    
    var headers: [String : String]? {
        [
            "accept": "application/json",
            "Authorization": "Bearer \(NFConfiguration.accessToken.getValue())"
        ]
    }
}
