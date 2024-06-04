//
//  NFSearchView.swift
//  MovieBox
//
//  Created by Arun on 09/05/24.
//

import UIKit

enum PlaceholderText: String {
    case search = "Type text to search", noItems = "No items available"
}

final class NFSearchView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            NFMovieItemTableViewCell.self,
            forCellReuseIdentifier: NFMovieItemTableViewCell.Identifier
        )
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 100
        return tableView
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = PlaceholderText.search.rawValue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.textColor = .label
        label.textAlignment = .center
        return label
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
        addSubview(placeholderLabel)
        addSubview(tableView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            placeholderLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10),
            placeholderLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            placeholderLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    func showPlaceholder(type: PlaceholderText) {
        placeholderLabel.text = type.rawValue
        placeholderLabel.isHidden = false
    }
    
    func hidePlaceholder() {
        placeholderLabel.isHidden = true
    }
}
