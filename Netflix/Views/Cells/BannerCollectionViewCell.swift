//
//  BannerCollectionViewCell.swift
//  Netflix
//
//  Created by Arun on 13/04/24.
//

import UIKit

final class BannerCollectionViewCell: UICollectionViewCell {
    
    static let Identifier = String(describing: BannerCollectionViewCell.self)
    
    private let bannerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .bordered()
        button.setTitle("Play", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.configuration = .bordered()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Download", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    private let transparentView : UILayoutGuide  = {
        let layoutGuide = UILayoutGuide()
        return layoutGuide;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerImageView)
        contentView.addSubview(playButton)
        contentView.addSubview(downloadButton)
        contentView.addLayoutGuide(transparentView)
        addGradient()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        layer.frame = contentView.bounds
        layer.addSublayer(gradientLayer)
    }
    
    private func addConstraints() {
        
        let bannerImageConstraints = [
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        
        let buttonConstraints = [
            transparentView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            transparentView.widthAnchor.constraint(equalToConstant: 1),
            transparentView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            transparentView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            playButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            playButton.rightAnchor.constraint(equalTo: transparentView.leftAnchor, constant: -15),
            playButton.widthAnchor.constraint(equalTo: downloadButton.widthAnchor),
            
            downloadButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            downloadButton.leftAnchor.constraint(equalTo: transparentView.rightAnchor, constant: 15),
        ]
        
        NSLayoutConstraint.activate(bannerImageConstraints + buttonConstraints)
    }
    
    func config(model: MovieItem?) {
        
        guard let model else { return }
        
        if let posterPath = model.backdropPath {
            let fullImageURLString = ImageRequestBuilder.get(for: posterPath, width: Int(500))
            
            if let posterURL = URL(string: fullImageURLString) {
                bannerImageView.sd_setImage(with: posterURL)
            }
        }
    }
}
