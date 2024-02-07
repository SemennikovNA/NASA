//
//  DetailViewController.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit
import SnapKit

final class DetailViewController: UIViewController {
    
    //MARK: - Properties
    
    private var textForLabel = TextForTitle()
    
    //MARK: - User interface elements
    
    private var verticalScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.bounces = true
        scroll.alwaysBounceVertical = true
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
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
        view.addSubviews(verticalScroll)
        verticalScroll.addSubviews(contentView)
        contentView.addSubviews(pictureView, detailDescriptionView)
        
        // Setup label's
        detailDescriptionView.setupLabels(with: textForLabel)
    }
}

//MARK: - Private extension

private extension DetailViewController {
    
    func setupConstraints() {
        
        // Vertical scroll
        verticalScroll.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    
        // Content view
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(verticalScroll)
            make.width.equalToSuperview()
        }
        
        // Picture view
        pictureView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(400)
        }
        
        // Detail description view
        detailDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(pictureView.snp.bottom)
            make.leading.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
}
