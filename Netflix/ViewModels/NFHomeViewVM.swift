//
//  NFHomeViewViewModel.swift
//  Netflix
//
//  Created by Arun on 14/04/24.
//

import Foundation

final class NFHomeViewVM {
    
    var sections = [Section]()
    
    private let repository: MovieDataRespository
    
    init(repository: MovieDataRespository) {
        self.repository = repository
        setupSections()
    }
    
    private func setupSections() {
        
        sections.append(Section.banner(
            viewModel: NFBannerViewModel()
        ))
        
        sections.append(Section.nowPlaying(
            viewModel: NFCategoryViewModel(name: NFList.nowPlaying.name, items: [])
        ))
        
        sections.append(Section.popular(
            viewModel: NFCategoryViewModel(name: NFList.popular.name, items: [])
        ))
        
        sections.append(Section.topRated(
            viewModel: NFCategoryViewModel(name: NFList.topRated.name, items: [])
        ))
        
        sections.append(Section.upcoming(
            viewModel: NFCategoryViewModel(name: NFList.upcoming.name, items: [])
        ))
    }
    
    internal func get(categoryList: NFCategoryListType) async throws -> MovieResponse? {
        
        if let response: MovieResponse = try await NFAPICaller.shared.get(categoryList) {
            return response
        }
        return nil
    }
    
    internal func setResponse(category: NFList, response: MovieResponse) {
        if let section = sections.first(where: { $0.category == category }) {
            
            let movieResults = response.results
            
            switch section {
            case .banner:
                break
            case .nowPlaying(let vm):
                vm.setMovieItems(movieResults)
            case .popular(let vm):
                vm.setMovieItems(movieResults)
            case .topRated(let vm):
                vm.setMovieItems(movieResults)
            case .upcoming(let vm):
                vm.setMovieItems(movieResults)
            }
        }
    }
    
    internal func setBannerResponse(response: MovieItem) {
        if let section = sections.first(where: { $0.category ==  NFList.banner}) {
            switch section {
            case .banner(let vm):
                vm.setModel(model: response)
            default:
                break
            }
        }
    }
    
    internal func saveMovie(_ movie: MovieItem) -> Bool {
        repository.save(movie)
    }
}
