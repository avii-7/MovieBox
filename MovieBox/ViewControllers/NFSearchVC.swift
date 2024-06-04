//
//  NFSearchVC.swift
//  MovieBox
//
//  Created by Arun on 11/05/24.
//

import UIKit

final class NFSearchVC: UIViewController {
    
    private var searchResultView: NFSearchView!
    
    private let viewModel: NFSearchViewVM
    
    init(viewModel: NFSearchViewVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        searchResultView = NFSearchView()
        view = searchResultView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupViewController()
    }
    
    private func setupViews(){
        searchResultView.tableView.delegate = self
        searchResultView.tableView.dataSource = self
    }
    
    private func setupViewController() {
        title = "Search"
        
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    private func getMovieList(for text: String) {
        Task { @MainActor [weak self] in
            do {
                let movieResponseList = try await self?.viewModel.getMovieList(for: text)
                
                guard let self else { return }

                viewModel.setMovieItems(movieResponseList)
                searchResultView.tableView.reloadData()
                
                if let movieResponseList, movieResponseList.results.isEmpty == false {
                    searchResultView.hidePlaceholder()
                }
                else {
                    searchResultView.showPlaceholder(type: PlaceholderText.noItems)
                }
            }
            catch {
                print("Error \(error)")
            }
        }
    }
}

extension NFSearchVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: NFMovieItemTableViewCell.Identifier,
            for: indexPath
        ) as? NFMovieItemTableViewCell {
            
            let model = viewModel.movieList[indexPath.row]
            cell.config(model)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = viewModel.movieList[indexPath.row]
        let detailVC = NFDetailVC(movie: model)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension NFSearchVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.isEmpty == false {
            getMovieList(for: text)
        }
        else {
            viewModel.setMovieItems(nil)
            searchResultView.tableView.reloadData()
            searchResultView.showPlaceholder(type: PlaceholderText.search)
        }
    }
}
