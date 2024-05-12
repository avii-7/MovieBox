//
//  SearchViewController.swift
//  Netflix
//
//  Created by Arun on 09/04/24.
//

import UIKit

final class NFSearchVC: UIViewController {
    
    override func loadView() {
        view = NFSearchView()
    }
    
    private let searchResultVC: NFSearchResultVC = {
        let controller = NFSearchResultVC()
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.searchController?.searchBar.becomeFirstResponder()
    }
    
    private func setupViewController() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        let searchController = UISearchController(searchResultsController: searchResultVC)
        searchController.searchResultsUpdater = searchResultVC
        navigationItem.searchController = searchController
    }
}
