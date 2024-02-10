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
    let networkManager = NetworkManager.shared
    let cache = ImageCache.shared
    var pictureArr: [DayPictureModel] {
        didSet {
            DispatchQueue.main.async {
                self.pictureCollectionView.reloadData()
            }
        }
    }
    
    //MARK: - User interface elements
    
    private let pictureCollectionView = PictureCollectionView()
    
    
    //MARK: - Initialize
    
    init() {
        self.pictureArr = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    //MARK: - Private methods
    /// Setup user elements in self view
    private func setupView() {
        // Setup view
        view.backgroundColor = .black
        view.addSubviews(pictureCollectionView)
        
        // Signature delegates
        signatureDelegates()
    }
    
    /// Method for signature delegates
    private func signatureDelegates() {
        pictureCollectionView.delegate = self
        pictureCollectionView.dataSource = self
        networkManager.delegate = self
    }
    
    private func fetchData() {
        networkManager.fetchData(count: 20) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

//MARK: - Extension

extension DayPictureViewController: NetworkManagerDelegate {
    
    func didUpdateDayPicture(_ networkManager: NetworkManager, model: [DayPictureModel]) {
        self.pictureArr = model
    }
    
    func didFailWithError(_ error: Error) {
        print(error.localizedDescription)
    }
}


//MARK: UICollectionViewDelegates methods

extension DayPictureViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return max(0, pictureArr.count - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pictureCollectionView.dequeueReusableCell(withReuseIdentifier: PictureCollectionViewCell.reuseIdentifire, for: indexPath) as! PictureCollectionViewCell
        cell.layer.cornerRadius = cell.frame.size.width / 9
        cell.clipsToBounds = true
        let image = UIImage(named: "nasa")
        let dataForItem = pictureArr[indexPath.item + 1]
        cell.setupPictureCollectionCell(with: dataForItem, image: image!)
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
            let image = UIImage(named: "nasa")
            if let firstPicture = pictureArr.first {
                  header.setupHeaderView(with: firstPicture, image: image!)
                  header.layoutSubviews()
              }
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
    /// Setup constraints for search view controller
    func setupConstraints() {
        // Picture collection view
        pictureCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
            make.width.equalTo(view.snp.width)
        }
    }
}
