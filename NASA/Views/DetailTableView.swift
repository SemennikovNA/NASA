//
//  DetailTableView.swift
//  NASA
//
//  Created by Nikita on 08.02.2024.
//

import UIKit

class DetailTableView: UITableView {
    
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
        register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
    }
}
