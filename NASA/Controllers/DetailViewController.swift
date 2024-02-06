//
//  DetailViewController.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

final class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Properties
    
    private var textForLabel = TextForTitle()
    
    //MARK: - User interface elements
    
    private var horizontalScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.bounces = true
        scroll.alwaysBounceVertical = true
        return scroll
    }()
    private lazy var contentView = UIView()
    private var pictureView = DetailPictureView()
    private var detailDescriptionView = DetailDescriptionView()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupView()
        setupConstraints()
    }
    
    //MARK: - Private
    
    private func setupView() {
        // Setup view's
        view.addSubviews(horizontalScroll)
        horizontalScroll.addSubviews(contentView)
        contentView.addSubviews(pictureView, detailDescriptionView)
        
        // Setup label's
        detailDescriptionView.setupLabels(with: textForLabel)
        
        horizontalScroll.contentSize = CGSize(width: contentView.frame.size.width, height: contentView.frame.size.width)
        horizontalScroll.delegate = self
    }
}

//MARK: - Private extension

private extension DetailViewController {
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Horizontal scroll
            horizontalScroll.topAnchor.constraint(equalTo: view.topAnchor),
            horizontalScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content view
            contentView.topAnchor.constraint(equalTo: horizontalScroll.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: horizontalScroll.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: horizontalScroll.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: horizontalScroll.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: horizontalScroll.widthAnchor),
            
            // Picture view
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -20),
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -20),
            pictureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            pictureView.heightAnchor.constraint(equalToConstant: 400),
            
            // Detail description view
            detailDescriptionView.topAnchor.constraint(equalTo: pictureView.bottomAnchor),
            detailDescriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            detailDescriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            detailDescriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
