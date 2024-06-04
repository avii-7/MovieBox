//
//  NFVideoDetailView.swift
//  Netflix
//
//  Created by Arun on 12/05/24.
//

import UIKit
import YouTubeiOSPlayerHelper

final class NFDetailView: UIView {
    
    let ytPlayerView: YTPlayerView = {
        let view = YTPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    let placeholderYTLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.text = "No video available"
        label.isHidden = true
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
        backgroundColor = .systemBackground
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(ytPlayerView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(placeholderYTLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            ytPlayerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            ytPlayerView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            ytPlayerView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            ytPlayerView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: ytPlayerView.bottomAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10),
            descriptionLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            
            placeholderYTLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 130),
            placeholderYTLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            placeholderYTLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    func startLoading() {
        activityIndicatorView.startAnimating()
    }
    
    func stopLoading() {
        activityIndicatorView.stopAnimating()
    }
}
