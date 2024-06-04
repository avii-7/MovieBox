//
//  NFVideoDetailVM.swift
//  MovieBox
//
//  Created by Arun on 12/05/24.
//

import Foundation

final class NFDetailVM {
    
    func getVideos(category: NFCategory, id: Int) async throws -> NFCategoryVideoResponse? {
        
        let endPoint: NFCategoryVideEndPoint
        
        switch category {
        case .Movie:
            endPoint = NFCategoryVideEndPoint.Movie(id: id)
        case .Tv:
            endPoint = NFCategoryVideEndPoint.TV(id: id)
        case .People:
            endPoint = NFCategoryVideEndPoint.People(id: id)
        }
        
        if let response: NFCategoryVideoResponse = try await NFAPICaller.shared.get(endPoint) {
            return response
        }
        
        return nil
    }
}
