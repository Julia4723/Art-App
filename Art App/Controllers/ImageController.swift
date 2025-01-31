//
//  ImageController.swift
//  Art App
//
//  Created by user on 30.01.2025.
//

import UIKit

final class ImageController: UIViewController {
    
    private let workModel: Work?
    
    private let imageView = UIImageView()
    var imageV = String()
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setup()
        
        if let work = workModel {
            configure(model: work)
        }
    }
    
    init(workModel: Work) {
        self.workModel = workModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Work) {
        imageView.image = UIImage(named: model.image)
    }
    
    @objc private func actionButton() {
        print("Button")
        navigationController?.popViewController(animated: true)
    }
}

private extension ImageController {
    func setup() {
        addSubviews()
        setupImage()
        setupButton()
        setupLayout()
    }
    
    func addSubviews() {
        [imageView, button].forEach {
            view.addSubview($0)
        }
    }
    
    func setupButton() {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "xmark.circle")
        config.baseForegroundColor = .black
        config.buttonSize = .large  // Автоматический размер
        button.configuration = config
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
    }
    
    func setupImage() {
        imageView.contentMode = .scaleAspectFit
        imageView.transform = CGAffineTransform(rotationAngle: .pi / 2) // Поворачиваем на 90°
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.height, height: view.frame.width)
        imageView.center = view.center
    }
}

private extension ImageController {
    func setupLayout() {
        [imageView, button].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            
        ])
    }
}
