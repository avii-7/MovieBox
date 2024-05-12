//
//  NFVideoDetailView.swift
//  Netflix
//
//  Created by Arun on 12/05/24.
//

import UIKit
import YouTubeiOSPlayerHelper

final class NFVideoDetailView: UIView {
    
    let ytPlayerView: YTPlayerView = {
        let view = YTPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(ytPlayerView)
        addSubview(descriptionLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            ytPlayerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            ytPlayerView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            ytPlayerView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            ytPlayerView.heightAnchor.constraint(equalToConstant: 300),

            descriptionLabel.topAnchor.constraint(equalTo: ytPlayerView.bottomAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    func startLoading() {
        activityIndicatorView.startAnimating()
    }
    
    func stopLoading() {
        activityIndicatorView.stopAnimating()
    }
}
