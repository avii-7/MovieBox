//
//  DownloadsViewController.swift
//  Netflix
//
//  Created by Arun on 09/04/24.
//

import UIKit

final class NFDownloadsVC: UIViewController {

    private var downloadView: NFDownloadView!
    
    private let viewModel: NFDownloadVM
    
    init(viewModel: NFDownloadVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        downloadView = NFDownloadView()
        view = downloadView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViewController()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchAllMovies()
        showPlaceholderIfEmpty()
        downloadView.tableView.reloadData()
    }
    
    private func setupTableView() {
        downloadView.tableView.dataSource = self
        downloadView.tableView.delegate = self
    }
    
    private func setupViewController() {
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func showPlaceholderIfEmpty() {
        let visible = viewModel.movieList.isEmpty
        downloadView.placeholderLabel.isHidden = !visible
    }
}

extension NFDownloadsVC: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let model = viewModel.movieList[indexPath.row]
            viewModel.delete(using: model.id)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

