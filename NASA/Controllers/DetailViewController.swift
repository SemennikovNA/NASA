//
//  DetailViewController.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private var horizontalScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.bounces = true
        return scroll
    }()
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    private var pictureView = PictureView()
    
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
        contentView.addSubviews(pictureView)
        
        
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
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            // Picture view
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pictureView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
}
