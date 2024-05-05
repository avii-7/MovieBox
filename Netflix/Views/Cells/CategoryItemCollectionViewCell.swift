//
//  MovieItemCollectionViewCell.swift
//  Netflix
//
//  Created by Arun on 13/04/24.
//

import UIKit
import SDWebImage

final class CategoryItemCollectionViewCell: UICollectionViewCell {
    
    static let Identifier = String(describing: CategoryItemCollectionViewCell.self)
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func config(_ viewModel: MovieItem) {
        let imageUrlString = ImageRequestBuilder.get(for: viewModel.posterPath)
        if let url = URL(string: imageUrlString) {
            imageView.sd_setImage(with: url)
        }
    }
}
