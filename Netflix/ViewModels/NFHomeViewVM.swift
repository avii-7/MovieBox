//
//  NFHomeViewViewModel.swift
//  Netflix
//
//  Created by Arun on 14/04/24.
//

import Foundation

final class NFHomeViewVM {
    
    var sections = [Section]()
    
    init() {
        setupSections()
    }
    
    private func setupSections() {
        
        if let bannerURL = URL(string: "www.google.com") {
            sections.append(.banner(viewModel: NFBannerViewModel(bannerURL: bannerURL)))
        }

        sections.append(Section.nowPlaying(
            viewModel: NFCategoryViewModel(name: Category.nowPlaying.rawValue, items: [])
        ))
        
        sections.append(Section.popular(
            viewModel: NFCategoryViewModel(name: Category.popular.rawValue, items: [])
        ))
        
        sections.append(Section.topRated(
            viewModel: NFCategoryViewModel(name: Category.topRated.rawValue, items: [])
        ))
        
        sections.append(Section.upcoming(
            viewModel: NFCategoryViewModel(name: Category.upcoming.rawValue, items: [])
        ))
    }
    
    internal func get(category: Category) async throws -> MovieResponse? {
        if let response: MovieResponse = try await NFAPICaller.shared.get(category.endPoint) {
            return response
        }
        return nil
    }
    
    internal func setResponse(category: Category, response: MovieResponse) {
        if let section = sections.first(where: { $0.category == category }) {
            
            let movieResults = response.results
            
            switch section {
            case .nowPlaying(let vm):
                vm.setMovieItems(movieResults)
            case .popular(let vm):
                vm.setMovieItems(movieResults)
            case .topRated(let vm):
                vm.setMovieItems(movieResults)
            case .upcoming(let vm):
                vm.setMovieItems(movieResults)
            default:
                break
            }
        }
    }
}
