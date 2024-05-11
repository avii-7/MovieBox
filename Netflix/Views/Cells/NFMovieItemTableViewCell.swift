//
//  NFUpcomingTableViewCell.swift
//  Netflix
//
//  Created by Arun on 05/05/24.
//

import UIKit

final class NFMovieItemTableViewCell: UITableViewCell {
    
    static let Identifier = String(describing: NFMovieItemTableViewCell.self)
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.label
        label.text = "Movie Title"
        label.numberOfLines = 0
        return label
    }()
    
    private let playImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "play.circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playImageView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 10),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            playImageView.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 10),
            playImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            playImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playImageView.widthAnchor.constraint(equalToConstant: 30),
            playImageView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func config(_ model: MovieItem) {
        let imageUrlString = ImageRequestBuilder.get(for: model.posterPath)
        if let url = URL(string: imageUrlString) {
            posterImageView.sd_setImage(with: url)
        }
        
        titleLabel.text = model.title
    }
}
