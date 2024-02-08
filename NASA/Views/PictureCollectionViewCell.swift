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
    
    private lazy var contentCellView = UIView()
    private lazy var pictureCellView = UIImageView()
    private lazy var pictureLabel = UILabel(font: .systemFont(ofSize: 16), textColor: .white)
    
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
    
    func setupPictureCollectionCell(with model: TextForTitle) {
        pictureLabel.text = model.textForCollection
    }
    
    //MARK: - Private method
    
    private func setupCollectionCell() {
        contentView.addSubviews(contentCellView)
        contentCellView.addSubviews(pictureCellView)
        pictureCellView.addSubviews(pictureLabel)
        pictureCellView.image = UIImage(named: "nasa")
    }
    
    private func setupConstraints() {
        
        // Content cell view
        contentCellView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        // Picture cell view
        pictureCellView.snp.makeConstraints { make in
            make.edges.equalTo(contentCellView)
        }
        
        // Picture label
        pictureLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(pictureLabel).inset(10)
            make.bottom.equalTo(pictureLabel).inset(10)
        }
    }
}
