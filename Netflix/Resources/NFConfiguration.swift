//
//  NFConfiguration.swift
//  Netflix
//
//  Created by Arun on 18/05/24.
//

import Foundation

enum NFConfiguration: String {
    
    case accessToken = "ACESS_TOKEN"
    
    func getValue() -> String {
        if let result = Bundle.main.object(forInfoDictionaryKey: self.rawValue) as? String {
            return result
        }
        
        return ""
    }
}
