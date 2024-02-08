//
//  DayPictureViewController.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

class DayPictureViewController: UIViewController {
    
    //MARK: - Properties
    
    let textForLabel = TextForTitle()
    
    //MARK: - User interface elements
    
    private let pictureCollectionView = PictureCollectionView()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupView()
        setupConstraints()
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        // Setup view
        view.backgroundColor = .black
        view.addSubviews(pictureCollectionView)
        
        // Setup picture collection view
        pictureCollectionView.delegate = self
        pictureCollectionView.dataSource = self
    }
}

//MARK: - Extension
//MARK: UICollectionDelegate, UICollectionDataSource, UICollectionViewDelegateFlowLayout methods

extension DayPictureViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pictureCollectionView.dequeueReusableCell(withReuseIdentifier: PictureCollectionViewCell.reuseIdentifire, for: indexPath) as! PictureCollectionViewCell
        cell.setupPictureCollectionCell(with: textForLabel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCell = CGSize(width: 180, height: 100)
        let firstItemSize = CGSize(width: collectionView.bounds.width, height: 100)
        
        if indexPath.item == 0 {
            return firstItemSize
        } else {
            return sizeCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets = UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 30)
        return insets
    }
}

//MARK: - Private extension

private extension DayPictureViewController {
    
    func setupConstraints() {
        pictureCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
            make.width.equalTo(view.snp.width)
        }
    }
}
