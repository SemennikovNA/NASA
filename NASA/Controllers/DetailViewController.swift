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
    private lazy var descriptionTableView = DescriptionTableView()
    
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
        contentView.addSubviews(descriptionTableView)
    }
}

//MARK: - Extension

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = descriptionTableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.detailCellID, for: indexPath) as? DescriptionTableViewCell else { return UITableViewCell() }
        cell.setupCellData(with: textForLabel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height
    }
}

//MARK: - Private extension

private extension DetailViewController {
    
    func setupConstraints() {
        
        // Vertical scroll
        verticalScroll.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(view)
        }
    
        // Content view
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(verticalScroll)
            make.width.equalToSuperview()
        }
        
        // Description table view
        descriptionTableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(contentView)
        }
    }
}
