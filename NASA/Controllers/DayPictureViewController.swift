//
//  DayPictureViewController.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

class DayPictureViewController: UIViewController {
    
    //MARK: - Properties
    
    let mokData = MokData()
    
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
        cell.layer.cornerRadius = cell.frame.size.width / 9
        cell.clipsToBounds = true
        cell.setupPictureCollectionCell(with: mokData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCell = CGSize(width: 190, height: 200)
        return sizeCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let lineSpacing: CGFloat = 10
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = pictureCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderReusableView.reuseIdentifire, for: indexPath) as! HeaderReusableView
            header.setupHeaderView(with: mokData)
            header.layoutSubviews()
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 150, height: 200)
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
