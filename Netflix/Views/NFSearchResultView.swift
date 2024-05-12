//
//  NFSearchView.swift
//  Netflix
//
//  Created by Arun on 09/05/24.
//

import UIKit

final class NFSearchResultView: UIView {
    
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
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "No items available"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.isHidden = true
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
}
