//
//  DayPictureViewController.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

class DayPictureViewController: UIViewController {
    
    //MARK: - User interface elements
    
    private let pictureCollectionView = PictureCollectionView()
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    //MARK: - Properties
    
    let mokData = MokData()
    let networkManager = NetworkManager.shared
    let cache = ImageCache.shared
    var pictureArr: [DayPictureModel] {
        didSet {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.pictureCollectionView.reloadData()
            }
        }
    }
    
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
        DispatchQueue.main.async {
            self.fetchData()
        }
        setupView()
        setupConstraints()
    }
    
    //MARK: - Private methods
    /// Setup user elements in self view
    private func setupView() {
        // Setup view
        view.backgroundColor = .black
        view.addSubviews(pictureCollectionView, activityIndicator)
        
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
        networkManager.fetchData(count: 11) { result in
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

//MARK: UIScrollViewDelegate methods

//extension DayPictureViewController: UIScrollViewDelegate {
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let downloadPosition = scrollView.contentOffset.y
//        if downloadPosition > (pictureCollectionView.contentSize.height - 100 - scrollView.frame.size.height) {
//            networkManager.fetchData(count: 10) { result in
//                switch result {
//                case .success(let data):
//                    self.pictureArr.append(data)
//                    DispatchQueue.main.async {
//                        self.pictureCollectionView.reloadData()
//                    }
//                case .failure(let failure):
//                    print("Ошибка \(failure)")
//                }
//            }
//        }
//    }
//}

//MARK: UICollectionViewDelegates methods

extension DayPictureViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pictureCollectionView.dequeueReusableCell(withReuseIdentifier: PictureCollectionViewCell.reuseIdentifire, for: indexPath) as! PictureCollectionViewCell
        cell.layer.cornerRadius = cell.frame.size.width / 9
        cell.clipsToBounds = true
        
        let data = pictureArr[indexPath.item]
        if let hdurl = data.hdurl, let image = cache.getImage(for: hdurl as NSString) {
            cell.setupPictureCollectionCell(with: data, with: image)
        } else {
            if let hdurl = data.hdurl, let imageUrl = URL(string: hdurl) {
                networkManager.fetchImage(withURL: imageUrl) { result in
                    switch result {
                    case .success(let image):
                        DispatchQueue.main.async {
                            cell.setupPictureCollectionCell(with: data, with: image)
                        }
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
        }
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let copyrightLabel = pictureArr[indexPath.item].copyright, let titleLabel = pictureArr[indexPath.item].title, let explanationLabel = pictureArr[indexPath.item].explanation, let image = cache.getImage(for: pictureArr[indexPath.item].hdurl! as NSString) else { return }
        
        let detailVC = DetailViewController()
            detailVC.copyrightTitle = copyrightLabel
            detailVC.headTitle = titleLabel
            detailVC.descriptionTitle = explanationLabel
            detailVC.dayImage = image
            
        navigationController?.pushViewController(detailVC, animated: true)
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
            header.layoutSubviews()
            if let firstPicture = pictureArr.first, let imageUrl = firstPicture.hdurl as? NSString {
                if let image = cache.getImage(for: imageUrl) {
                    DispatchQueue.main.async {
                        header.setupHeaderView(with: firstPicture)
                        header.setupImageForHeader(image: image)
                    }
                }
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
        
        // Activity indicator
        activityIndicator.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}
