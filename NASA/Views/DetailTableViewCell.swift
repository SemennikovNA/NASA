//
//  DetailTableViewCell.swift
//  NASA
//
//  Created by Nikita on 08.02.2024.
//

import UIKit
import SnapKit

class DetailTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseIdentifier = "DetailTableCell"
    
    //MARK: - User interface elements
    
    private lazy var contentCellView = UIView()
    private lazy var authorLabel = UILabel(font: .systemFont(ofSize: 17), textColor: .gray)
    private lazy var headLabel = UILabel(font: .systemFont(ofSize: 20), textColor: .white)
    private lazy var descriptionLabel = UILabel(font: .systemFont(ofSize: 17), numberOfLines: 0, textColor: .white)
    
    //MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Call method's
        setupCell()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Method
    
    func setupDataForCell(author: String, head: String, description: String, image: UIImage) {
        authorLabel.text = author
        headLabel.text = head
        descriptionLabel.text = description
    }
    
    //MARK: - Private method
    
    private func setupCell() {
        contentCellView.backgroundColor = .black
        contentView.addSubviews(contentCellView)
        contentCellView.addSubviews(authorLabel, headLabel, descriptionLabel)
    }
    
    private func setupContraints() {
        // Content cell view
        contentCellView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        // Author lable
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(contentCellView.snp_topMargin).offset(10)
            make.leading.trailing.equalTo(contentCellView).inset(20)
            make.height.equalTo(30)
        }
        // Head label
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp_bottomMargin).offset(10)
            make.leading.trailing.equalTo(contentCellView).inset(20)
            make.height.equalTo(50)
        }
        // Description label
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(headLabel.snp_bottomMargin).offset(10)
            make.leading.trailing.bottom.equalTo(contentCellView).inset(20)
            
        }
    }
}
