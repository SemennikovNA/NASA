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
    let dayImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
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
        dayImage.image = image
    }
    
    //MARK: - Private method
    
    private func setupCell() {
        contentCellView.backgroundColor = .black
        contentView.addSubviews(contentCellView)
        contentCellView.addSubviews(dayImage, authorLabel, headLabel, descriptionLabel)
    }
    
    private func setupContraints() {
        // Content cell view
        contentCellView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        NSLayoutConstraint.activate([
            dayImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            dayImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dayImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dayImage.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        // Day image
//        dayImage.snp.makeConstraints { make in
//            make.top.equalTo(contentView)
//            make.leading.trailing.equalTo(contentView)
//            make.height.equalTo(350)
//        }
        
        // Author lable
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(dayImage.snp_bottomMargin).offset(20)
            make.leading.trailing.equalTo(contentCellView).inset(20)
            make.height.equalTo(35)
        }
        
        // Head label
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp_bottomMargin).offset(10)
            make.leading.trailing.equalTo(contentCellView).inset(20)
            make.height.equalTo(60)
        }
        
        // Description label
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(headLabel.snp_bottomMargin).offset(15)
            make.leading.trailing.bottom.equalTo(contentCellView).inset(20)
            
        }
    }
    
}
