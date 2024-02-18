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

    var copyrightTitle = ""
    var headTitle = ""
    var descriptionTitle = ""
    var dayImage = UIImage()
    
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
    /// Setup user elements in self view
    private func setupView() {
        // Setup navigation items
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        
        // Setup view's
        view.addSubviews(verticalScroll)
        verticalScroll.addSubviews(contentView)
        contentView.addSubviews(detailTableView)
        
        // Signature delegate
        signatureDelegates()
    }
    
    /// Method for signature delegates
    private func signatureDelegates() {
        verticalScroll.delegate = self
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    //MARK: - Objective - C method
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Extension

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for cell in detailTableView.visibleCells {
            if let pictureCell = cell as? DetailTableViewCell {
                let yOffset = scrollView.contentOffset.y
                let newHeight = max(-yOffset, 0) // Новая высота изображения, основанная на прокрутке
                pictureCell.dayImage.frame.size.height = newHeight
                detailTableView.beginUpdates()
                detailTableView.endUpdates()
            }
        }
    }
}


//MARK: UITableViewDelegates methods
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "DetailTableCell", for: indexPath) as! DetailTableViewCell
        cell.setupDataForCell(author: copyrightTitle, head: headTitle, description: descriptionTitle, image: dayImage)
        return cell
    }
}

//MARK: - Private extension

private extension DetailViewController {
    
    /// Setup constraints for search view controller
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
