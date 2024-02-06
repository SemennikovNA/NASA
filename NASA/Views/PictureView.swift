//
//  PictureView.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

final class PictureView: UIView {
    
    //MARK: - User interface elements
    
    private lazy var pictureImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "nasa")
        return image
    }()
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Call method's
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private method
    
    private func setupView() {
        self.addSubviews(pictureImageView)
    }
    
    //MARK: - Methods
    /// Setup image to picture view
    func configureView(with model: Any) {
    
    }
}

//MARK: - Private extension

private extension PictureView {
    /// Setup constraints for picture image view
    func setupConstraints() {
        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: self.topAnchor),
            pictureImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pictureImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pictureImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
