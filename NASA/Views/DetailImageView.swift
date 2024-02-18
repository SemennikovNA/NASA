//
//  DetailImageView.swift
//  NASA
//
//  Created by Nikita on 18.02.2024.
//

import UIKit

class DetailImageView: UIView {
    
    var detailImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    //MARK: - Inititalize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Call method's
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Method
    
    func setupImage(with image: UIImage) {
        detailImage.image = image
    }
    
    //MARK: - Private method
    
    private func setupView() {
        self.addSubviews(detailImage)
    }
}

private extension DetailImageView {
    
    func setupConstraints() {
        detailImage.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
    }
}
