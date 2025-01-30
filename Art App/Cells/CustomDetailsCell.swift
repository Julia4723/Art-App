//
//  CustomDetailsCell.swift
//  Art App
//
//  Created by user on 28.01.2025.
//

import UIKit

final class CustomDetailsCell: UITableViewCell {
    
    private let customView = CustomDetailsView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Work) {
        customView.configure(model: model)
    }
}


private extension CustomDetailsCell {
    func setup() {
        contentView.addSubview(customView)
        contentView.backgroundColor = .white
        setupLayout()
    }
}


private extension CustomDetailsCell {
    func setupLayout() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}
