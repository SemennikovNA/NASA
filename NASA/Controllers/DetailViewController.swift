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
        scroll.contentInset = UIEdgeInsets(top: -100, left: 0, bottom: 0, right: 0)
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    private var contentView: UIView = {
        let view = UIView()
        return view
    }()
    private var detailImage = DetailImageView()
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
        contentView.addSubviews(detailImage, detailTableView)
        
        // Setup image
        detailImage.detailImage.image = dayImage
        
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
//MARK: UIScrollViewDelegate methods
extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        zoomImageWhenScrolling(scrollView)
        transitTitleToNavigationBar(indentation: 170, uiElement: scrollView)
    }
    
    /// Calculation of image size when scrolling
    private func zoomImageWhenScrolling(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        let imageViewHeight = max(600 - yOffset, 0)
        let offset: CGFloat = 50
        detailImage.snp.updateConstraints { make in
            make.height.equalTo(imageViewHeight + offset)
        }
    }
    
    /// Setup label in navigation bar when scrolling
    private func transitTitleToNavigationBar(indentation: CGFloat, uiElement: UIScrollView) {
        let indentation = indentation
        if uiElement.contentOffset.y > indentation {
            navigationItem.title = self.headTitle
            navigationController?.navigationBar.isTranslucent = false
        } else {
            navigationItem.title = nil
            navigationController?.navigationBar.isTranslucent = true
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
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        // Content view
        contentView.snp.makeConstraints { make in
            make.center.equalTo(verticalScroll)
            make.top.equalTo(verticalScroll).inset(-200)
            make.leading.trailing.bottom.equalTo(verticalScroll)
            make.width.equalTo(verticalScroll.snp.width)
        }
        // Detail image view
        detailImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView)
            make.height.equalTo(400)
        }
        // Detail table
        detailTableView.snp.makeConstraints { make in
            make.top.equalTo(detailImage.snp.bottom)
            make.leading.trailing.bottom.equalTo(contentView)
        }
    }
}
