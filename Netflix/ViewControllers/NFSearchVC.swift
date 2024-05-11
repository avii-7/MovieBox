//
//  SearchViewController.swift
//  Netflix
//
//  Created by Arun on 09/04/24.
//

import UIKit

final class NFSearchVC: UIViewController {
    
    private var searchView: NFSearchView!
    
    private var viewModel: NFSearchViewVM!
    
    override func loadView() {
        searchView = NFSearchView()
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NFSearchViewVM()
        setupViewController()
        setupViews()
    }
    
    private func setupViewController() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func getMovieList(for text: String) {
        Task { @MainActor in
            do {
                let movieList = try await viewModel.getMovieList(for: text)
                if let movieList {
                    viewModel.setMovieItems(movieList)
                    searchView.tableView.reloadData()
                }
            }
            catch {
                print("Error \(error)")
            }
        }
    }
    
    private func setupViews(){
        searchView.searchBar.delegate = self
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
    }
}

extension NFSearchVC: UISearchBarDelegate {
    
    // Todo: Look for best practises
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text {
             getMovieList(for: text)
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
}
