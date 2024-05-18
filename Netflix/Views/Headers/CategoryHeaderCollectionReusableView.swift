//
//  CategoryHeaderCollectionReusableView.swift
//  Netflix
//
//  Created by Arun on 14/04/24.
//

import UIKit

final class CategoryHeaderCollectionReusableView: UICollectionReusableView {
    
    static let Identifier = String(describing: CategoryItemCollectionViewCell.self)
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Jason Bling"
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5)
        ])
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
}
