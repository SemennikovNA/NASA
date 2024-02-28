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
    let refreshControl = UIRefreshControl()
    var perPage = 20
    var currentPage = 1
    var totalPages = 1
    var isLoading = false
    var headerData: DayPictureModel
    var allPictureArray: [DayPictureModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.pictureCollectionView.reloadData()
            }
        }
    }
    
    //MARK: - Initialize
    
    init() {
        self.headerData = DayPictureModel(copyright: "", title: "", explanation: "", url: "")
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
            self.networkManager.fetchData(perPage: 21) { result in
            }
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
        
        // Added refresh control for collection view
        refreshControl.addTarget(self, action: #selector(loadMore), for: .valueChanged)
        pictureCollectionView.refreshControl = refreshControl
        
        // Signature delegates
        signatureDelegates()
    }
    
    /// Method for signature delegates
    private func signatureDelegates() {
        pictureCollectionView.delegate = self
        pictureCollectionView.dataSource = self
        networkManager.dayPictureDelegate = self
    }
    
    //MARK: - Objective - C method
    /// Method for push to detail view into headerReuseView
    @objc func headerGestureTap() {
        
        let hdurl = headerData.url
        let image = cache.getImage(for: hdurl as NSString)
        let copyrightLabel = headerData.copyright ?? ""
        let titleLabel = headerData.title
        let explanationLabel = headerData.explanation
        let detailVC = DetailViewController()
        detailVC.copyrightTitle = copyrightLabel
        detailVC.headTitle = titleLabel
        detailVC.descriptionTitle = explanationLabel
        detailVC.dayImage = image!
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    /// Method for mode image load
    @objc func loadMore() {
        self.currentPage += 1
        refreshControl.endRefreshing()
        DispatchQueue.main.async { [self] in
            self.networkManager.fetchData(perPage: perPage) { result in
                switch result {
                case .success(let data):
                    var newData: [DayPictureModel] = []
                    newData.append(data)
                    let startIndex = self.allPictureArray.count
                    self.allPictureArray.append(contentsOf: newData)
                    
                    let indexPaths = (startIndex..<self.allPictureArray.count).map { IndexPath(item: $0, section: 0) }
                    self.pictureCollectionView.insertItems(at: indexPaths)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

//MARK: - Extension
//MARK: DayPictureDataDelegate method
extension DayPictureViewController: DayPictureDataDelegate {
    
    func didUpdatуHeader(_ networkManager: NetworkManager, model: DayPictureModel) {
        self.headerData = model
    }
    
    func didUpdateDayPicture(_ networkManager: NetworkManager, model: [DayPictureModel]) {
        var data = model
        if !data.isEmpty {
            data.removeFirst()
            self.allPictureArray.append(contentsOf: data)
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error.localizedDescription)
    }
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == allPictureArray.count - 1 {  //numberofitem count
            DispatchQueue.main.async {
                self.loadMore()
            }
        }
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
            let imageUrl = headerData.url
            let title = headerData.title
            if let image = cache.getImage(for: imageUrl as NSString) {
                header.setupHeaderView(title: title, image: image)
            } else if let imageURL = URL(string: imageUrl) {
                networkManager.fetchImage(withURL: imageURL) { result in
                    switch result {
                    case .success(let image):
                        DispatchQueue.main.async {
                            header.setupHeaderView(title: title, image: image)
                        }
                    case .failure(let failure):
                        print(failure)
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
