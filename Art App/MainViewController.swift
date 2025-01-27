//
//  ViewController.swift
//  Art App
//
//  Created by user on 27.01.2025.
//

import UIKit

final class MainViewController: UITableViewController {
    
    private let cellIdentifier = "cell"
    private let networkManager = NetworkManager.shared
    private let dataManager: IDataManager
    
    private var artModel: [Artist]?
    
    init(dataManager: IDataManager) {
        self.dataManager = dataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        tableView.separatorStyle = .none
        tableView.register(CustomCell.self, forCellReuseIdentifier: cellIdentifier)
        fetchArtist()
    }
    
    func fetchArtist() {
        networkManager.fetchAF { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let artists):
                    print("Success: \(artists)")
                    self?.artModel = artists
                    self?.tableView.reloadData()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artModel?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomCell else { return UITableViewCell()}
        
        if let item = artModel?[indexPath.row]  {
            cell.configure(model: item)
        }
        
        return cell
    }
    
}


