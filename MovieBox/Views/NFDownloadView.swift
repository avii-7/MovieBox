//
//  NFDownloadView.swift
//  MovieBox
//
//  Created by Arun on 18/05/24.
//

import UIKit

final class NFDownloadView: UIView {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            NFMovieItemTableViewCell.self,
            forCellReuseIdentifier: NFMovieItemTableViewCell.Identifier
        )
        tableView.rowHeight = 100
        return tableView
    }()
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No downloads available"
        label.textColor = .label
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title3)
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
        addSubview(tableView)
        addSubview(placeholderLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            placeholderLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10),
            placeholderLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            placeholderLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
        ])
    }

}
