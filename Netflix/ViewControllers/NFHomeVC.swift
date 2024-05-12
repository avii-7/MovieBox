//
//  HomeViewController.swift
//  Netflix
//
//  Created by Arun on 09/04/24.
//

import UIKit

final class HomeVC: UIViewController {
    
    private var homeView: NFHomeView!
    
    private var viewModel: NFHomeViewVM!
    
    override func loadView() {
        homeView = NFHomeView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        setupViewModel()
        setupView()
        callApis()
        view.backgroundColor = .systemBackground
    }
    
    private func configNavBar() {
        
        let imageView = UIImageView(image: .netflix)
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.contentMode = .scaleAspectFit
        
        let navBarItem = UIBarButtonItem(customView: imageView)
        
        navigationItem.leftBarButtonItem = navBarItem
        
        let personImage = UIImage(systemName: "person")
        let personBarButtonItem = UIBarButtonItem(image: personImage, style: .done, target: self, action: .none)
        
        let playImage = UIImage(systemName: "play.rectangle")
        let playBarButtonItem = UIBarButtonItem(image: playImage, style: .done, target: self, action: .none)
        
        navigationItem.rightBarButtonItems = [personBarButtonItem, playBarButtonItem]
        navigationController?.navigationBar.tintColor = .white
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    private func setupView() {
        homeView.collectionView.dataSource = self
    }
    
    private func setupViewModel() {
        viewModel = NFHomeViewVM()
    }
    
    private func callApis() {
        Task { @MainActor in
            do {
                if let response: MovieResponse = try await viewModel.get(categoryList: .Movie(list: .nowPlaying)) {
                    viewModel.setResponse(category: .nowPlaying, response: response)
                    homeView.reloadSection(at: IndexSet(integer: NFList.nowPlaying.index))
                }
                
                if let response: MovieResponse = try await viewModel.get(categoryList: .Movie(list: .popular)){
                    viewModel.setResponse(category: .popular, response: response)
                    homeView.reloadSection(at: IndexSet(integer: NFList.popular.index))
                }
                
                if let response: MovieResponse = try await viewModel.get(categoryList: .Movie(list: .topRated)) {
                    viewModel.setResponse(category: .topRated, response: response)
                    homeView.reloadSection(at: IndexSet(integer: NFList.topRated.index))
                }
                
                if let response: MovieResponse = try await viewModel.get(categoryList: .Movie(list: .upcoming)) {
                    viewModel.setResponse(category: .upcoming, response: response)
                    homeView.reloadSection(at: IndexSet(integer: NFList.upcoming.index))
                }
            }
            catch {
                print(error)
            }
        }
    }
}

extension HomeVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch viewModel.sections[section] {
        case .banner:
            return 1
        case .nowPlaying(let vm):
            return vm.items.count
        case .popular(let vm):
            return vm.items.count
        case .topRated(let vm):
            return vm.items.count
        case .upcoming(let vm):
            return vm.items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.Identifier, for: indexPath) as? BannerCollectionViewCell {
                return cell;
            }
        }
        else {
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryItemCollectionViewCell.Identifier,
                for: indexPath
            ) as? CategoryItemCollectionViewCell {
                
                let section = viewModel.sections[indexPath.section]
                
                switch section {
                case .nowPlaying(let vm):
                    let movieItem = vm.items[indexPath.row]
                    cell.config(movieItem)
                case .popular(let vm):
                    let movieItem = vm.items[indexPath.row]
                    cell.config(movieItem)
                case .topRated(let vm):
                    let movieItem = vm.items[indexPath.row]
                    cell.config(movieItem)
                case .upcoming(let vm):
                    let movieItem = vm.items[indexPath.row]
                    cell.config(movieItem)
                default: // banner
                    break
                }
                
                return cell;
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CategoryHeaderCollectionReusableView.Identifier,
            for: indexPath
        ) as? CategoryHeaderCollectionReusableView {
            
            let section = viewModel.sections[indexPath.section]
            
            switch section {
            case .nowPlaying(let vm):
                view.setTitle(title: vm.name)
            case .popular(let vm):
                view.setTitle(title: vm.name)
            case .topRated(let vm):
                view.setTitle(title: vm.name)
            case .upcoming(let vm):
                view.setTitle(title: vm.name)
            case .banner:
                break
            }
            
            return view
        }
        
        return .init()
    }
}
