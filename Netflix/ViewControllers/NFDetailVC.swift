//
//  NFVideoDetailVC.swift
//  Netflix
//
//  Created by Arun on 12/05/24.
//

import UIKit

final class NFDetailVC: UIViewController {
    
    private let movie: MovieItem
    
    private let viewModel: NFDetailVM
    
    private var detailView: NFDetailView!

    override func loadView() {
        detailView = NFDetailView()
        view = detailView
    }
    
    init(movie: MovieItem) {
        self.movie = movie
        self.viewModel = NFDetailVM()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        loadVideo()
        setupViews()
    }
    
    private func setupViewController() {
        //navigationController.sho
    }
    
    private func loadVideo() {
        Task { @MainActor in
            do {
                if let response = try await viewModel.getVideos(category: NFCategory.Movie, id: movie.id) {
                    
                   let video = response.results.first {
                        $0.type == TypeEnum.trailer &&
                        $0.site == Site.youTube
                    }
                    
                    guard let video else { return }
                    
                    detailView.ytPlayerView.load(withVideoId: video.key)
                }
                
            }
            catch {
                print("Error: \(error)")
            }
        }
    }
    
    private func setupViews() {
        detailView.titleLabel.text = movie.title
        detailView.descriptionLabel.text = movie.overview
    }
}
