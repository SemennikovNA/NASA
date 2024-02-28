//
//  HeaderReusableView.swift
//  NASA
//
//  Created by Nikita on 09.02.2024.
//

import UIKit

final class HeaderReusableView: UICollectionReusableView {
    
    //MARK: - Properties
    
    static let reuseIdentifire = "HeaderReuseIdentifire"
    
    //MARK: - User interface elements
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
    private lazy var pictureView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    private lazy var pictureLabel = UILabel(font: .boldSystemFont(ofSize: 22), numberOfLines: 0, textColor: .white, textAlignment: .center)
    var gestureRecognize = UITapGestureRecognizer()
    
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.activityIndicator.startAnimating()
        }
        
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
    /// Setup header view
    func setupHeaderView(title: String, image: UIImage) {
        pictureLabel.text = title
        pictureView.image = image
        activityIndicator.stopAnimating()
    }
    
    /// Add logic for touch header
    func addTargetForGestureRecognizer(target: Any, selector: Selector) {
        gestureRecognize.addTarget(target, action: selector)
    }
    
    //MARK: - Private methods
    /// Setup header elements
    private func setupHeaderViewElements() {
        // Setup view
        self.addSubviews(pictureView, activityIndicator)
        pictureView.addSubviews(pictureLabel)
        pictureView.addGestureRecognizer(gestureRecognize)
        pictureView.isUserInteractionEnabled = true
    }
    
    /// Setup constraints for element in Header view
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
        
        // Activity indicator
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }
}
