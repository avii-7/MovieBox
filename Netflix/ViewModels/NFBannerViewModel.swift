//
//  NFBannerViewModel.swift
//  Netflix
//
//  Created by Arun on 14/04/24.
//

import Foundation

class NFBannerViewModel {
    
    private(set) var bannerURL: URL
    
    init(bannerURL: URL) {
        self.bannerURL = bannerURL
    }
    
    func setUrl(_ url: URL) {
        bannerURL = url
    }
}
