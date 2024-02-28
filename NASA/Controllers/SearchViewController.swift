//
//  SearchViewController.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

final class SearchViewController: UIViewController, UISearchControllerDelegate {
    
    //MARK: - Properties
    
    var cache = ImageCache.shared
    var networkManager = NetworkManager.shared
    var searchResult: [Item] = [] {
        didSet {
            print(self.searchResult.count)
            DispatchQueue.main.async {
                self.searchCollection.reloadData()
            }
        }
    }
    
    //MARK: - User interface elements
    
    private var searchController = UISearchController(searchResultsController: nil)
    private let searchCollection = PictureCollectionView()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupView()
        setupSearchBar()
        setupConstraints()
    }
    
    //MARK: - Private method
    /// Setup user elements in self view
    private func setupView() {
        // Setup view
        view.backgroundColor = .black
        view.addSubviews(searchCollection)
        
        // Signature delegates
        signatureDelegates()
    }
    
    /// Method for signature delegates
    private func signatureDelegates() {
        searchCollection.delegate = self
        searchCollection.dataSource = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        networkManager.searchResultDelegate = self
    }
    
    /// Setup search bar in
    private func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .default
        searchController.searchBar.showsLargeContentViewer = true
        searchController.searchBar.placeholder = "Найти"
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchTextField.showsMenuAsPrimaryAction = true
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

//MARK: - Extension
//MARK: SearchResultUpdateDelegate
extension SearchViewController: SearchResultDataDelegate {
    // Added data for search collection
    func didUpdateSearchResult(_ networkManager: NetworkManager, model: [Item]) {
        self.searchResult = model
    }
    // Print error for delegate 
    func didFailWithError(_ error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: UICollectionViewDelegates
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Setup collection number item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    // Setup cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: PictureCollectionViewCell.reuseIdentifire, for: indexPath) as! PictureCollectionViewCell
        cell.layer.cornerRadius = cell.frame.size.width / 15
        cell.clipsToBounds = true
        
        let item = searchResult[indexPath.item]
        
        if let title = item.data.first?.title, let imageUrlString = item.links.first?.href {
            if let image = cache.getImage(for: imageUrlString as NSString) {
                cell.setupSearchDataCollectionCell(with: title, image: image, index: indexPath)
            } else if let imageUrl = URL(string: imageUrlString) {
                networkManager.fetchImage(withURL: imageUrl) { result in
                    switch result {
                    case .success(let image):
                        DispatchQueue.main.async {
                            cell.setupSearchDataCollectionCell(with: title, image: image, index: indexPath)
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
        }
        
        return cell
    }
    
    // Methods for setup size and insets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let spacinLine: CGFloat = 10
        return spacinLine
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeForCell = CGSize(width: searchCollection.bounds.size.width, height: 190)
        return sizeForCell
    }
}

//MARK: UISearchResultsUpdating
extension SearchViewController: UISearchBarDelegate {
    // Hiding the keyboard
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    // Send a request based on the text you enter
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        guard let url = networkManager.createAllImageURL(search: true, searchString: text, perPage: 10) else { return }
        networkManager.fetchSearchResult(url: url) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

//MARK: - Private extension
private extension SearchViewController {
     /// Setup constraints for search view controller
    func setupConstraints() {
        searchCollection.snp.makeConstraints { make in
            make.top.equalTo(view.snp_topMargin)
            make.leading.equalTo(view.snp_leadingMargin)
            make.trailing.equalTo(view.snp_trailingMargin)
            make.bottom.equalTo(view.snp_bottomMargin)
        }
    }
}
