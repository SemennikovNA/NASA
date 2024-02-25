//
//  DayPictureViewController.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

final class DayPictureViewController: UIViewController {
    
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
    
    let networkManager = NetworkManager.shared
    let cache = ImageCache.shared
    var dayPicture: [TodayPictureModel]
    var allPictureArray: [DayPictureModel] {
        didSet {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.pictureCollectionView.reloadData()
            }
        }
    }
    
    //MARK: - Initialize
    
    init() {
        self.dayPicture = []
        self.allPictureArray = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        fetchData()
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
        networkManager.dayPictureDelegate = self
    }
    
    /// Method for fetch data
    private func fetchData() {
        networkManager.fetchData(count: 10) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    //MARK: - Objective - C method
    /// Method for push to detail view into headerReuseView
    @objc func headerGestureTap() {

        let pictureData = allPictureArray[0]
        let hdurl = pictureData.url
        let image = cache.getImage(for: hdurl as NSString)
        let copyrightLabel = pictureData.copyright ?? ""
        let titleLabel = pictureData.title
        let explanationLabel = pictureData.explanation
        let detailVC = DetailViewController()
        detailVC.copyrightTitle = copyrightLabel
        detailVC.headTitle = titleLabel
        detailVC.descriptionTitle = explanationLabel
        detailVC.dayImage = image!
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - Extension
//MARK: DayPictureDataDelegate method
extension DayPictureViewController: DayPictureDataDelegate {
    
    func fetchTodayPicture(_ networkManager: NetworkManager, model: [TodayPictureModel]) {
        self.dayPicture = model
    }
    
    
    func didUpdateDayPicture(_ networkManager: NetworkManager, model: [DayPictureModel]) {
        self.allPictureArray = model
    }
    
    func didFailWithError(_ error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: UIScrollViewDelegate method
extension DayPictureViewController: UIScrollViewDelegate {

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        
//        let downloadPosition = scrollView.contentOffset.y
//        if downloadPosition > (pictureCollectionView.contentSize.height - 100 - scrollView.frame.size.height) {
//            print("Был скролл")
//            networkManager.fetchData(count: 10) { result in
//                switch result {
//                case .success(let data):
//                    DispatchQueue.main.async {
//                        self.pictureArr.append(data)
//                        self.pictureCollectionView.reloadData()
//                    }
//                case .failure(let failure):
//                    print("Ошибка \(failure)")
//                }
//            }
//        }
//    }
}

//MARK: UICollectionViewDelegates methods
extension DayPictureViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPictureArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pictureCollectionView.dequeueReusableCell(withReuseIdentifier: PictureCollectionViewCell.reuseIdentifire, for: indexPath) as! PictureCollectionViewCell
        cell.layer.cornerRadius = cell.frame.size.width / 9
        cell.clipsToBounds = true
        
        let data = allPictureArray[indexPath.item]
        let url = data.url
        
        if let image = cache.getImage(for: url as NSString) {
            cell.setupPictureCollectionCell(with: data, image: image)
        } else if let imageUrl = URL(string: url) {
            networkManager.fetchImage(withURL: imageUrl) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.setupPictureCollectionCell(with: data, image: image)
                    }
                case .failure(let failure):
                    print(failure)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pictureData = allPictureArray[indexPath.item]
        let hdurl = pictureData.url
        let image = cache.getImage(for: hdurl as NSString)
        let copyrightLabel = pictureData.copyright ?? ""
        let titleLabel = pictureData.title
        let explanationLabel = pictureData.explanation
        let detailVC = DetailViewController()
        detailVC.copyrightTitle = copyrightLabel
        detailVC.headTitle = titleLabel
        detailVC.descriptionTitle = explanationLabel
        detailVC.dayImage = image!
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCell = CGSize(width: 170, height: 200)
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
            header.addTargetForGestureRecognizer(target: self, selector: #selector(headerGestureTap))
            if let firstPicture = dayPicture.first, let imageUrl = firstPicture.url as? NSString {
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
//MARK: Constraints for DayPictureViewController
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
