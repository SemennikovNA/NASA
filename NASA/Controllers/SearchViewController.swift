//
//  SearchViewController.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

final class SearchViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    //MARK: - Properties
     
    var text = MokData()
    
    //MARK: - User interface elements
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupView()
        setupSearchBar()
        setupConstraints()
    }
    
    //MARK: - Private method

    private func setupView() {
        view.backgroundColor = .black
    }
    
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

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

//MARK: - Private extension

private extension SearchViewController {
     
    func setupConstraints() {
        
    }
}
