//
//  BannerCollectionViewCell.swift
//  Netflix
//
//  Created by Arun on 13/04/24.
//

import UIKit

protocol NFMovieCellProtocol {
    func config(model: MovieItem)
}

final class BannerCollectionViewCell: UICollectionViewCell {
    
    static let Identifier = String(describing: BannerCollectionViewCell.self)
    
    private let bannerImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let transparentView : UILayoutGuide  = {
        let layoutGuide = UILayoutGuide()
        return layoutGuide;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bannerImageView)
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
        
        let transparentViewConstraints = [
            transparentView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            transparentView.widthAnchor.constraint(equalToConstant: 1),
            transparentView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            transparentView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(bannerImageConstraints + transparentViewConstraints)
    }
}

extension BannerCollectionViewCell: NFMovieCellProtocol {
    func config(model: MovieItem) {
        
        if let posterPath = model.backdropPath {
            let fullImageURLString = ImageRequestBuilder.get(for: posterPath, width: Int(500))
            
            if let posterURL = URL(string: fullImageURLString) {
                bannerImageView.sd_setImage(with: posterURL)
            }
        }
    }
}
