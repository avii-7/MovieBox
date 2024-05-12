//
//  NFSearchResultVC.swift
//  Netflix
//
//  Created by Arun on 11/05/24.
//

import UIKit

final class NFSearchResultVC: UIViewController {
    
    private var searchResultView: NFSearchResultView!
    
    private var viewModel: NFSearchViewVM!
    
    override func loadView() {
        searchResultView = NFSearchResultView()
        view = searchResultView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NFSearchViewVM()
        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    private func setupViews(){
        searchResultView.tableView.delegate = self
        searchResultView.tableView.dataSource = self
    }
    
    private func getMovieList(for text: String) {
        Task { @MainActor [weak self] in
            do {
                let movieList = try await self?.viewModel.getMovieList(for: text)
                if let movieList {
                    guard let self else { return }
                    viewModel.setMovieItems(movieList)
                    searchResultView.tableView.reloadData()
                    
                    if movieList.results.isEmpty {
                        searchResultView.placeholderLabel.isHidden = false
                    }
                    else {
                        searchResultView.placeholderLabel.isHidden = true
                    }
                }
            }
            catch {
                print("Error \(error)")
            }
        }
    }
}

extension NFSearchResultVC: UITableViewDataSource, UITableViewDelegate {
    
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
}

extension NFSearchResultVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.isEmpty == false {
            getMovieList(for: text)
            view.isHidden = false
        }
        else {
            searchResultView.tableView.reloadData()
        }
    }
}
