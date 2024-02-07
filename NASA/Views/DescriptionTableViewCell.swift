//
//  DescriptionTableViewCell.swift
//  NASA
//
//  Created by Nikita on 07.02.2024.
//

import UIKit

final class DescriptionTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let detailCellID = "DetailCellId"
    
    //MARK: - User interface elements
    
    private lazy var contentCellView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var dayPictureView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "nasa")
        return image
    }()
    private lazy var authorLabel = UILabel(font: .boldSystemFont(ofSize: 16), textColor: .lightGray)
    private lazy var headLabel = UILabel(font: .boldSystemFont(ofSize: 20), textColor: .white)
    private lazy var descriptionLabel = UILabel(font: .systemFont(ofSize: 17), numberOfLines: 0, textColor: .white)
    
    //MARK: - Initializ

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Call method's
        setupTableCell()
    }
    
    //MARK: - Private method
    /// Setup tabel cell
    private func setupTableCell() {
        contentView.addSubviews(contentCellView)
        contentCellView.addSubviews()
        
        // Setup constraints
        setupConstraints()
    }
    
    /// Setup constraints for table cell
    private func setupConstraints() {
        // Content view
        contentCellView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(contentView)
        }
        
        // Day picture view
        dayPictureView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentCellView)
            make.height.equalTo(contentCellView).offset(300)
        }
        
        // Author label
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(dayPictureView.snp_bottomMargin).offset(20)
            make.leadingMargin.equalTo(contentCellView.snp_leadingMargin).offset(10)
            make.trailingMargin.equalTo(contentCellView.snp_trailingMargin).offset(10)
            make.height.equalTo(30)
        }
        
        // Head label
        headLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp_bottomMargin).offset(10)
            make.leadingMargin.equalTo(contentCellView.snp_leadingMargin).offset(10)
            make.trailingMargin.equalTo(contentCellView.snp_trailingMargin).offset(10)
            make.height.equalTo(50)
        }
        
        // Description label
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(headLabel.snp_bottomMargin).offset(20)
            make.leading.equalTo(contentCellView.snp_leadingMargin).offset(10)
            make.trailing.equalTo(contentCellView.snp_trailingMargin).offset(10)
            make.bottom.equalTo(contentCellView.snp_bottomMargin)
        }
    }
    
    //MARK: - Methods
    
    func setupCellData(with model: TextForTitle) {
        authorLabel.text = model.authorLabelText
        headLabel.text = model.headLabelText
        descriptionLabel.text = model.descriptionTextViewText
    }
}
