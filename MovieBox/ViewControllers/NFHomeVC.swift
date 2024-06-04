//
//  HomeViewController.swift
//  MovieBox
//
//  Created by Arun on 09/04/24.
//

import UIKit

final class NFHomeVC: UIViewController {
    
    private var homeView: NFHomeView!
    
    private let viewModel: NFHomeViewVM
    
    init(viewModel: NFHomeViewVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        homeView = NFHomeView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        setupView()
        callApis()
        view.backgroundColor = .systemBackground
    }
    
    private func configNavBar() {
        
        let imageView = UIImageView(image: .logo)
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
    }
    
    private func setupView() {
        homeView.collectionView.dataSource = self
        homeView.collectionView.delegate = self
    }
    
    private func callApis() {
        Task { @MainActor in
            do {
                if let response: MovieResponse = try await viewModel.get(categoryList: .Movie(list: .nowPlaying)) {
                    viewModel.setResponse(category: .nowPlaying, response: response)
                    homeView.reloadSection(type: NFList.nowPlaying)
                }
                
                if let response: MovieResponse = try await viewModel.get(categoryList: .Movie(list: .popular)) {
                    viewModel.setResponse(category: .popular, response: response)
                    homeView.reloadSection(type: NFList.popular)
                    
                    if let randomMovie = response.results.randomElement() {
                        viewModel.setBannerResponse(response: randomMovie)
                        homeView.reloadSection(type: NFList.banner)
                    }
                }
                
                if let response: MovieResponse = try await viewModel.get(categoryList: .Movie(list: .topRated)) {
                    viewModel.setResponse(category: .topRated, response: response)
                    homeView.reloadSection(type: NFList.topRated)
                }
                
                if let response: MovieResponse = try await viewModel.get(categoryList: .Movie(list: .upcoming)) {
                    viewModel.setResponse(category: .upcoming, response: response)
                    homeView.reloadSection(type: NFList.upcoming)
                }
            }
            catch {
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension NFHomeVC: UICollectionViewDataSource {
    
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
        
        let identifier = indexPath.section == 0
        ? BannerCollectionViewCell.Identifier
        : CategoryItemCollectionViewCell.Identifier
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        if let listCell = cell as? NFMovieCellProtocol {
            
            let section = viewModel.sections[indexPath.section]
            
            let model: MovieItem?
            
            switch section {
            case .nowPlaying(let vm):
                model = vm.items[indexPath.row]
            case .popular(let vm):
                model = vm.items[indexPath.row]
            case .topRated(let vm):
                model = vm.items[indexPath.row]
            case .upcoming(let vm):
                model = vm.items[indexPath.row]
            case .banner(let vm):
                model = vm.model
            }
            
            if let model {
                listCell.config(model: model)
            }
        }
        
        return cell
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

extension NFHomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let movie = getModel(at: indexPath) {
            let detailVC = NFDetailVC(movie: movie)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(actionProvider:  { _ in
            let downloadAction = UIAction(title: "Download", image: UIImage(systemName: "arrow.down")) { action in
                
                guard let indexPath = indexPaths.first else { return }
                
                if let movie = self.getModel(at: indexPath) {
                    let result = self.viewModel.saveMovie(movie)
                    if result == false {
                        print("Already exists")
                    }
                }
            }
            
            return UIMenu(options: .displayInline, children: [downloadAction])
        })
        return config
    }
}

extension NFHomeVC {
    
    private func getModel(at indexPath: IndexPath) -> MovieItem? {
        
        let section = viewModel.sections[indexPath.section]
        
        let movie: MovieItem?
        
        switch section {
        case .banner:
            movie = nil
        case .nowPlaying(let vm):
            movie = vm.items[indexPath.row]
        case .popular(let vm):
            movie = vm.items[indexPath.row]
        case .topRated(let vm):
            movie = vm.items[indexPath.row]
        case .upcoming(let vm):
            movie = vm.items[indexPath.row]
        }
        
        return movie
    }
}
