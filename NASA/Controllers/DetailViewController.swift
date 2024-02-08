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
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    private var detailTableView = DetailTableView()
    
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
        contentView.addSubviews(detailTableView)
        
        // Signature delegate
        detailTableView.delegate = self
        detailTableView.dataSource = self
//        detailTableView.backgroundColor = .white
    }
}

//MARK: - Extension

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "DetailTableCell", for: indexPath) as! DetailTableViewCell
        cell.setupDataForCell(with: textForLabel)
        return cell
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
            make.center.equalTo(verticalScroll)
            make.top.equalTo(verticalScroll).inset(-60)
            make.leading.trailing.bottom.equalTo(verticalScroll)
            make.width.equalTo(verticalScroll.snp.width)
        }
        
        // Detail table
        detailTableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(contentView)
            make.height.equalTo(contentView.snp.height)
        }
    }
}
