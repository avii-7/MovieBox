//
//  DownloadsViewController.swift
//  Netflix
//
//  Created by Arun on 09/04/24.
//

import UIKit

final class NFDownloadsVC: UIViewController {

    private var downloadView: NFDownloadView!
    
    private var viewModel: NFDownloadVM!
    
    override func loadView() {
        downloadView = NFDownloadView()
        view = downloadView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel = NFDownloadVM()
        setupViewController()
        setupTableView()
    }
    
    private func setupTableView() {
        downloadView.tableView.dataSource = self
        downloadView.tableView.delegate = self
    }
    
    private func setupViewController() {
        title = "Downloading"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
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
            viewModel.delete(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
}

