//
//  SearchViewController.swift
//  Netflix
//
//  Created by Arun on 09/04/24.
//

import UIKit

final class SearchVC: UIViewController {
    
    private var searchView: NFSearchView!
    
    override func loadView() {
        searchView = NFSearchView()
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
}
