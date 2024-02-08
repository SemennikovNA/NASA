//
//  DetailTableViewCell.swift
//  NASA
//
//  Created by Nikita on 08.02.2024.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let reuseIdentifier = "DetailTableCell"
    
    //MARK: - User interface elements
    
    private lazy var contentCellView = UIView()
    private lazy var dayImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "nasa")
        return image
    }()
    private lazy var authorLabel = UILabel(font: .systemFont(ofSize: 15), textColor: .lightGray)
    private lazy var headLabel = UILabel(font: .systemFont(ofSize: 20), textColor: .white)
    private lazy var descriptionLabel = UILabel(font: .systemFont(ofSize: 17), textColor: .white)
    
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
    
    func setupDataForCell(with model: TextForTitle) {
        
    }
    
    //MARK: - Private method
    
    private func setupCell() {
        contentView.addSubviews(contentCellView)
        contentCellView.addSubviews(dayImage)
    }
    
    private func setupContraints() {
        // Content cell view
        contentCellView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        // Day image
        dayImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentCellView)
            make.height.equalTo(400)
        }
    }
    
}
