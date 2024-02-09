//
//  HeaderReusableView.swift
//  NASA
//
//  Created by Nikita on 09.02.2024.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    
    //MARK: - Properties
    
    static let reuseIdentifire = "HeaderReuseIdentifire"
    
    //MARK: - User interface elements
    
    private lazy var pictureView = UIImageView()
    private lazy var pictureLabel = UILabel(font: .boldSystemFont(ofSize: 22), numberOfLines: 0, textColor: .white, textAlignment: .center)
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        // Call method's
        setupHeaderViewElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pictureView.layer.cornerRadius = pictureView.frame.size.width / 15
        pictureView.clipsToBounds = true
    }
    
    //MARK: - Method
    
    func setupHeaderView(with model: MokData) {
        pictureView.image = model.image
        pictureLabel.text = model.textForCollection
    }
        
    //MARK: - Private methods
    
    private func setupHeaderViewElements() {
        
        self.addSubviews(pictureView)
        pictureView.addSubviews(pictureLabel)
        
        self.layer.zPosition = 0
        pictureView.contentMode = .scaleAspectFill
    }

    private func setupConstraints() {
        // Picture view
        pictureView.snp.makeConstraints { make in
            make.top.equalTo(self.snp_topMargin).offset(10)
            make.leading.equalTo(self.snp_leadingMargin).inset(10)
            make.trailing.equalTo(self.snp_trailingMargin).inset(10)
            make.bottom.equalTo(self.snp_bottomMargin).offset(10)
        }
        
        // Picture label
        pictureLabel.snp.makeConstraints { make in
            make.leading.equalTo(pictureView.snp_leadingMargin)
            make.trailing.equalTo(pictureView.snp_trailingMargin)
            make.bottom.equalTo(pictureView.snp_bottomMargin).inset(10)
        }
    }
}
