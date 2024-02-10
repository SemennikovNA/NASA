//
//  PictureCollectionViewCell.swift
//  NASA
//
//  Created by Nikita on 08.02.2024.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let reuseIdentifire = "PrctureCollectionViewCell"
    
    //MARK: - User interface elements
    
    private lazy var pictureCellView = UIImageView()
    private lazy var pictureLabel = UILabel(font: .boldSystemFont(ofSize: 18), numberOfLines: 0, textColor: .white, textAlignment: .center)
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Call method's
        setupCollectionCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func setupPictureCollectionCell(with model: DayPictureModel) {
        pictureLabel.text = model.title
//        pictureCellView.image = model.hdurl
    }
    
    //MARK: - Private method
    
    private func setupCollectionCell() {
        contentView.addSubviews(pictureCellView)
        pictureCellView.addSubviews(pictureLabel)
        pictureCellView.contentMode = .scaleAspectFill
    }
    
    private func setupConstraints() {
         // Picture cell view
        pictureCellView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp_topMargin).inset(-10)
            make.bottom.equalTo(contentView.snp_bottomMargin).inset(-10)
            make.leading.equalTo(contentView.snp_leadingMargin).inset(-10)
            make.trailing.equalTo(contentView.snp_trailingMargin).inset(-10)
        }
        
        pictureLabel.snp.makeConstraints { make in
            make.leading.equalTo(pictureCellView.snp_leadingMargin)
            make.trailing.equalTo(pictureCellView.snp_trailingMargin)
            make.bottom.equalTo(pictureCellView.snp_bottomMargin).inset(10)
        }
    }
}
