//
//  CustomDetailsView.swift
//  Art App
//
//  Created by user on 28.01.2025.
//

import UIKit

final class CustomDetailsView: UIView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel.makeLabel(font: .systemFont(ofSize: 16, weight: .medium), textColor: .black)
    private let infoLabel = UILabel.makeLabel(font: .systemFont(ofSize: 14, weight: .regular), textColor: .systemGray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Work) {
        imageView.image = UIImage(named: model.image)
        titleLabel.text = model.title
        infoLabel.text = model.info
    }
    
}


private extension CustomDetailsView {
    func setup() {
        addSubviews()
        setupImage()
        setupLayout()
    }
    
    func addSubviews() {
        [titleLabel, imageView, infoLabel].forEach { view in
            addSubview(view)
        }
    }
}

private extension CustomDetailsView {

    func setupImage() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
    }
}

private extension CustomDetailsView {
    func setupLayout() {
        [titleLabel, imageView, infoLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 140),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            infoLabel.heightAnchor.constraint(equalToConstant: 80),
            infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
