//
//  NFVideoDetailVC.swift
//  Netflix
//
//  Created by Arun on 12/05/24.
//

import UIKit
import YouTubeiOSPlayerHelper

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
        setupDelegates()
        setupViews()
    }
    
    private func setupViewController() {
        //navigationController.sho
    }
    
    private func loadVideo() {
        detailView.ytPlayerView.isHidden = true
        
        Task { @MainActor [weak self] in
            do {
                if let response = try await self!.viewModel.getVideos(category: NFCategory.Movie, id: self!.movie.id) {
                    
                   let video = response.results.first {
                        $0.type == TypeEnum.trailer &&
                        $0.site == Site.youTube
                    }
                    
                    guard let video else {
                        print("No video available")
                        return
                    }
                    
                    self?.detailView.ytPlayerView.load(withVideoId: video.key)
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
    
    private func setupDelegates() {
        detailView.ytPlayerView.delegate = self
    }
}

extension NFDetailVC: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        detailView.ytPlayerView.isHidden = false
        print("Player is now ready !")
    }
}
