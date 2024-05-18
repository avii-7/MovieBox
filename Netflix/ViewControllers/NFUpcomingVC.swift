//
//  UpcomingViewController.swift
//  Netflix
//
//  Created by Arun on 09/04/24.
//

import UIKit

final class NFUpcomingVC: UIViewController {
    
    private var upcomingView: NFUpcomingView!
    
    private var viewModel: NFUpcomingVM!
    
    override func loadView() {
        upcomingView = NFUpcomingView()
        view = upcomingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel = NFUpcomingVM()
        setupViewController()
        setupTableView()
        getMovieList()
    }
    
    private func setupTableView() {
        upcomingView.tableView.dataSource = self
        upcomingView.tableView.delegate = self
    }
    
    private func getMovieList() {
        Task { @MainActor [weak self] in
            do {
                let movieList = try await self!.viewModel.getUpcomingMovieList()
                guard let self else { return }
                if let movieList {
                    viewModel.setMovieItems(movieList)
                    upcomingView.tableView.reloadData()
                }
            }
            catch {
                print("Error \(error)")
            }
        }
    }
    
    private func setupViewController() {
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
}

extension NFUpcomingVC: UITableViewDataSource, UITableViewDelegate {
    
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
