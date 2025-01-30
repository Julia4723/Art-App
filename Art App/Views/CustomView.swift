//
//  CustomView.swift
//  Art App
//
//  Created by user on 27.01.2025.
//

import UIKit

final class CustomView: UIView {
    private let nameLabel = UILabel.makeLabel(font: .systemFont(ofSize: 14, weight: .regular), textColor: .systemGray)
    private let descriptionLabel = UILabel.makeLabel(font: .systemFont(ofSize: 16, weight: .regular), textColor: .black, numberOfLines: 1)
    private let imageView = UIImageView()

    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func configure(model: Artist) {
        nameLabel.text = model.name
        descriptionLabel.text = model.bio
        imageView.image = UIImage(named: model.image)
        
    }
}

private extension CustomView {
    func setup() {
        addSubviews()
        setupImage()
        setupLayout()
    }
    
    func addSubviews() {
        [nameLabel, descriptionLabel, imageView].forEach { view in
            addSubview(view)
        }
    }
}

private extension CustomView {
    
    func setupImage() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
    }
}


private extension CustomView {
    func setupLayout() {
        [nameLabel, descriptionLabel, imageView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 160),
            imageView.heightAnchor.constraint(equalToConstant: 140),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
