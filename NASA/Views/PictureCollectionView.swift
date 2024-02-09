//
//  PictureCollectionView.swift
//  NASA
//
//  Created by Nikita on 08.02.2024.
//

import UIKit

class PictureCollectionView: UICollectionView {
    
    //MARK: - Initialize
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        super.init(frame: frame, collectionViewLayout: collectionLayout)
        
        // Call method's
        setupPictureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private method
    
    private func setupPictureCollectionView() {
        self.backgroundColor = .black
        register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.reuseIdentifire)
        register(PictureCollectionViewCell.self, forCellWithReuseIdentifier: PictureCollectionViewCell.reuseIdentifire)
    }
}
