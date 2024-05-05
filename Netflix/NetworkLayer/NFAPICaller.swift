//
//  NFAPICaller.swift
//  Netflix
//
//  Created by Arun on 14/04/24.
//

import Foundation



final class NFAPICaller {
    
    private init() { }
    
    static let shared = NFAPICaller()
    
    func get<T: Decodable>(_ endPoint: NFEndPointType) async throws -> T? {
        
        guard let url = endPoint.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = endPoint.headers
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest as URLRequest)
        
        if
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        }
        
        return nil
    }
}
