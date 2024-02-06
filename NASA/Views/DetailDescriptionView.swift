//
//  DetailDescriptionView.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

final class DetailDescriptionView: UIView {
    
    //MARK: - User interface elements
    
    private lazy var authorLabel = UILabel(font: .boldSystemFont(ofSize: 16), textColor: .lightGray)
    private lazy var headLabel = UILabel(font: .boldSystemFont(ofSize: 20), textColor: .white)
    private lazy var descriptionTextView: UILabel = {
        let textView = UILabel()
        textView.numberOfLines = 0
        textView.font = .systemFont(ofSize: 17)
        textView.textColor = .white
        return textView
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
        // Setup view
        self.addSubviews(authorLabel, headLabel, descriptionTextView)
        
        // Setup label's
        headLabel.adjustsFontSizeToFitWidth = true
        headLabel.minimumScaleFactor = 0.5
    }
    
    //MARK: - Method
    
    func setupLabels(with model: TextForTitle) {
        authorLabel.text = model.authorLabelText
        headLabel.text = model.headLabelText
        descriptionTextView.text = model.descriptionTextViewText
    }
    
}

//MARK: - Private extension

private extension DetailDescriptionView {
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Author label
            authorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            authorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            authorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            authorLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // Head label
            headLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            headLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            headLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            headLabel.heightAnchor.constraint(equalToConstant: 25),
            
            // Description text view
            descriptionTextView.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 5),
            descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        ])
    }
}
