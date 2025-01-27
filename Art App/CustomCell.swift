//
//  CustomCell.swift
//  Art App
//
//  Created by user on 27.01.2025.
//

import UIKit

final class CustomCell: UITableViewCell {
    private let customView = CustomView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Artist) {
        customView.configure(model: model)
    }
}


private extension CustomCell {
    func setup() {
        contentView.addSubview(customView)
        contentView.backgroundColor = .systemGray6
        setupLayout()
    }
}


private extension CustomCell {
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
