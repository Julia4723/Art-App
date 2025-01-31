//
//  ViewController.swift
//  Art App
//
//  Created by user on 27.01.2025.
//

import UIKit

final class MainViewController: UITableViewController {
    
    //MARK: - Private Property
    private let cellIdentifier = "cell"
    private let networkManager = NetworkManager.shared
    private let dataManager: IDataManager
    private var artistModel: [Artist]?
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredArtist: [Artist] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    //MARK: - Init
    init(dataManager: IDataManager) {
        self.dataManager = dataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchArtist()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - Methods
    func fetchArtist() {
        networkManager.fetchAF { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let artists):
                    print("Success: \(artists)")
                    self?.artistModel = artists
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredArtist.count : artistModel?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomCell else { return UITableViewCell()}
        
        if let artist = isFiltering ? filteredArtist[indexPath.row] : artistModel?[indexPath.row] {
            cell.configure(model: artist)
        }
        
        //        if let item = artistModel?[indexPath.row] {
        //            cell.configure(model: item)
        //        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = artistModel?[indexPath.row] else { return }
        let detailsVC = DetailsViewController(artist: item)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}


private extension MainViewController {
    func setupView() {
        tableView.separatorStyle = .none
        tableView.register(CustomCell.self, forCellReuseIdentifier: cellIdentifier)
        setupNavigationBar()
        setupSearchController()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Artists"
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = .white
        
        // Настраиваем текст заголовка для компактного вида
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        
        // Настраиваем текст для крупного вида навигационной панели
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        // Применяем настройки к навигационной панели
        navigationController?.navigationBar.standardAppearance = appearance // к большому нав бару
        navigationController?.navigationBar.scrollEdgeAppearance = appearance // к навбару когда скролл
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .black
        }
    }
    
}

//MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredArtist = artistModel?.filter { artist in
            artist.name.lowercased().contains(searchText.lowercased())
        } ?? []
        
        tableView.reloadData()
    }
}
