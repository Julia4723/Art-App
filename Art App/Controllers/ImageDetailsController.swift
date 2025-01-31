//
//  ImageDetailsController.swift
//  Art App
//
//  Created by user on 30.01.2025.
//

import UIKit

final class ImageDetailsController: UIViewController {
    
    private var workModel: Work?
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel.makeLabel(
        font: .systemFont(ofSize: 20, weight: .bold),
        textColor: .black
    )
    private let descriptionLabel = UILabel.makeLabel(
        font: .systemFont(ofSize: 14, weight: .regular),
        textColor: .systemGray
    )
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        
        if let work = workModel {
            configure(model: work)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    init(workModel: Work?) {
        self.workModel = workModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped() {
        print("Button")
        let image = workModel?.image
        let imageVC = ImageController(workModel: workModel!)
        imageVC.imageV = image ?? ""
        navigationController?.pushViewController(imageVC, animated: true)
    }
    
    func configure(model: Work) {
        imageView.image = UIImage(named: model.image)
        titleLabel.text = model.title
        descriptionLabel.text = model.info
    }
}

private extension ImageDetailsController {
    func setup() {
        addSubviews()
        setupImageView()
        setupButton()
        setupLayout()
    }
    
    func addSubviews() {
        [imageView, titleLabel, descriptionLabel, button].forEach {
            view.addSubview($0)
        }
    }
    
    func setupImageView() {
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 0
        imageView.contentMode = .scaleAspectFill
    }
    
    func setupButton() {
        button.setTitle("Open", for: .normal)
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}

private extension ImageDetailsController {
    func setupLayout() {
        [imageView, titleLabel, descriptionLabel, button].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
}
