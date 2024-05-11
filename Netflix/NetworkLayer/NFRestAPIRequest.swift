//
//  NFRestAPIRequest.swift
//  Netflix
//
//  Created by Arun on 11/05/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol NFRestAPIRequestProtocol {
    var urlComponents: URLComponents { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
}

struct NFRestAPIRequest: NFRestAPIRequestProtocol {
    
    var urlComponents: URLComponents
    
    var httpMethod: HTTPMethod
    
    var headers: [String : String]?
}

extension NFRestAPIRequest {
    
    init?(
       urlContruct: NFURLConstruct,
       httpMethod: HTTPMethod,
       headers: [String : String]?
   ) {
       
       guard let url = urlContruct.url else  {
           return nil
       }
       
       guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
           return nil
       }
       
       if let queryItems = urlContruct.queryItems {
           urlComponents.queryItems = queryItems
       }
       
       self.init(urlComponents: urlComponents, httpMethod: httpMethod, headers: headers)
   }
}
