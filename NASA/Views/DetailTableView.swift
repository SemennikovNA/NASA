//
//  DetailTableView.swift
//  NASA
//
//  Created by Nikita on 08.02.2024.
//

import UIKit

class DetailTableView: UITableView, UITableViewDelegate {
    
    //MARK: - Initialize
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        // Call method's
        setupDetailTable()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDetailTable() {
        delegate = self
        self.backgroundColor = .black
        register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
    }
}
