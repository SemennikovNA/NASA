//
//  DescriptionTableView.swift
//  NASA
//
//  Created by Nikita on 07.02.2024.
//

import UIKit
import SnapKit

final class DescriptionTableView: UITableView {
    
    
    //MARK: - Initialize

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        
        // Call method's
        setupTable()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private method
    
    private func setupTable() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.detailCellID)
    }
}

//MARK: - Private extension

private extension DescriptionTableView {
    
    func setupConstraints() {
        self.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(self)
        }
    }
}
