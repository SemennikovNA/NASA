//
//  SearchViewController.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

final class SearchViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    //MARK: - Properties
     
    var mokData = MokData()
    
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
    }
    
    /// Setup search bar in
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .default
        searchController.searchBar.showsLargeContentViewer = true
        searchController.searchBar.searchTextField.showsMenuAsPrimaryAction = true
        searchController.searchBar.placeholder = "Найти"
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.tintColor = .white
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

//MARK: - Extension

//MARK: UICollectionViewDelegates

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: PictureCollectionViewCell.reuseIdentifire, for: indexPath) as! PictureCollectionViewCell
        cell.setupPictureCollectionCell(with: mokData)
        cell.layer.cornerRadius = cell.frame.size.width / 15
        cell.clipsToBounds = true
        return cell
    }
    
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

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
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
