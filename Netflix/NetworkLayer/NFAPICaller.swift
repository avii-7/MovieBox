//
//  NFAPICaller.swift
//  Netflix
//
//  Created by Arun on 14/04/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

final class NFAPICaller {
    
    private init() { }
    
    static let shared = NFAPICaller()
    
    func get<T: Decodable>(_ restRequest: NFAPIRequestProtocol) async throws -> T? {
        
        guard let url = getURL(from: restRequest) else { return nil}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = restRequest.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = restRequest.headers
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest as URLRequest)
        
        if
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        }
        
        return nil
    }
    
    func getURL(from restRequest: NFAPIRequestProtocol) -> URL? {
    
    let baseURL = restRequest.baseURL
    
    guard var url = URL(string: baseURL) else { return nil }
    
    url.append(path: restRequest.version, directoryHint: .notDirectory)
    
    if restRequest.pathComponents.isEmpty == false {
        for pathComponent in restRequest.pathComponents {
            url.append(path: pathComponent, directoryHint: .notDirectory)
        }
    }
    
    guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
        return nil
    }
    
    if let queryItems = restRequest.queryItems {
        urlComponents.queryItems = queryItems
    }
    
    print(urlComponents.url ?? "Fail")
    
    return urlComponents.url
}
}
