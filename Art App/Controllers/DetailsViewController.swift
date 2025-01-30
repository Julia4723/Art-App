//
//  DetailsViewController.swift
//  Art App
//
//  Created by user on 27.01.2025.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    //MARK: - Private property
    private var artistModel: Artist?
    private let cellIdentifier = "cell"
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let tableView = UITableView()
    private let nameLabel = UILabel.makeLabel(font: .systemFont(ofSize: 20, weight: .bold), textColor: .black)
    private let descriptionLabel = UILabel.makeLabel(font: .systemFont(ofSize: 14, weight: .regular), textColor: .systemGray)
    private let imageView = UIImageView()
    private let biography = UILabel.makeLabel(text: "Biography", font: .systemFont(ofSize: 16, weight: .medium), textColor: .black)
    private let descriptionBiography = UILabel.makeLabel(font: .systemFont(ofSize: 14, weight: .regular), textColor: .systemGray)
    private let works = UILabel.makeLabel(text: "Works", font: .systemFont(ofSize: 16, weight: .medium), textColor: .black)
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        contentView.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(CustomDetailsCell.self, forCellReuseIdentifier: cellIdentifier)
        setup()
        
        if let artist = artistModel {
            configure(model: artist)
        }
    }
    
    init(artist: Artist? = nil) {
        self.artistModel = artist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Artist) {
        nameLabel.text = model.name
        descriptionLabel.text = model.bio
        imageView.image = UIImage(named: model.image)
        descriptionBiography.text = model.bio
    }
}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      artistModel?.works.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomDetailsCell else { return UITableViewCell()}
        if let modelElement = artistModel?.works[indexPath.row] {
            cell.configure(model: modelElement)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        280
    }
}

private extension DetailsViewController {
    func setup() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        addSubviews()
        setupImageView()
        setupLayout()
    }
    
    
    func addSubviews() {
        [nameLabel, descriptionLabel, imageView, biography, descriptionBiography, works, tableView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupImageView() {
        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
    }
}

private extension DetailsViewController {
    private func setupLayout() {
        [scrollView, contentView, nameLabel, descriptionLabel, imageView, biography, descriptionBiography, works, tableView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50),
            
            biography.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            biography.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            biography.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
           
            descriptionBiography.topAnchor.constraint(equalTo: biography.bottomAnchor, constant: 16),
            descriptionBiography.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionBiography.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionBiography.heightAnchor.constraint(equalToConstant: 80),
            
            works.topAnchor.constraint(equalTo: descriptionBiography.bottomAnchor, constant: 20),
            works.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            works.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: works.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(artistModel?.works.count ?? 0) * 280)
        ])
    }
}


