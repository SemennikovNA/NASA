//
//  SearchViewController.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

final class SearchViewController: UIViewController {
    
    //MARK: - Properties
     
    var text = TextForTitle()
    
    //MARK: - User interface elements
    
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupView()
        setupConstraints()
    }
    
    //MARK: - Private method
    
    private func setupView() {
    
    }
}

//MARK: - Private extension

private extension SearchViewController {
     
    func setupConstraints() {
    }
}
