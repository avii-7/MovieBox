//
//  NFVideoDetailVC.swift
//  Netflix
//
//  Created by Arun on 12/05/24.
//

import UIKit

final class NFVideoDetailVC: UIViewController {
    
    private var videoDetailView: NFVideoDetailView!
    
    private let movieId: String
    
    override func loadView() {
        videoDetailView = NFVideoDetailView()
        view = videoDetailView
    }
    
    init(movieId: String) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
