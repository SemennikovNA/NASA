//
//  NetworkManager.swift
//  NASA
//
//  Created by Nikita on 10.02.2024.
//

import UIKit

protocol DayPictureDataDelegate {
    func didUpdatуHeader(_ networkManager: NetworkManager, model: DayPictureModel)
    func didUpdateDayPicture(_ networkManager: NetworkManager, model: [DayPictureModel])
    func didFailWithError(_ error: Error)
}

protocol SearchResultDataDelegate {
    func didUpdateSearchResult(_ networkManager: NetworkManager, model: [Item])
    func didFailWithError(_ error: Error)
}

final class NetworkManager {
    
    //MARK: - Properties
    
    static let shared = NetworkManager()
    private let decoder = JSONDecoder()
    private let session = URLSession(configuration: .default)
    private let apiKey = "UU3VJDZp0yuGErh0Qc2H5Xrj9AvbjRlt9tjDUS44"
    var dayPictureDelegate: DayPictureDataDelegate?
    var searchResultDelegate: SearchResultDataDelegate?
    
    //MARK: - Initialize
    
    private init(){}
    
    //MARK: - Method
    /// Create url depending on parameters
    func createAllImageURL(search: Bool = false, searchString: String = "", count: Int) -> URL? {
        let tunnel = "https://"
        let url = "api.nasa.gov"
        let dayPic = "/planetary/apod?"
        let countItem = "count=\(count)"
        let key = "&api_key=\(self.apiKey)"
        let searchUrl = "images-"
        let searchKey = "/search?"
        let searchParameters = "q="
        
        switch search {
        case true:
            let searchPic = tunnel + searchUrl + url + searchKey + searchParameters + searchString
            let searchPicUrl = URL(string: searchPic)
            return searchPicUrl
        case false:
            let dayPic = tunnel + url + dayPic + countItem + key
            let urlDayPic = URL(string: dayPic)
            return urlDayPic
        }
    }
    
    //MARK: - Private method
    /// Fetch data for day picture url
    func fetchData(count: Int, completion: @escaping (Result<DayPictureModel, Error>) -> ()) {
        guard let dayCollection = createAllImageURL(count: count) else {
            completion(.failure(NetworkError.badUrl))
            return
        }
        
        session.dataTask(with: dayCollection) { data, response, error in
            guard let data else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            do {
                var nasaData = try self.decoder.decode([DayPictureModel].self, from: data)
                if let firstImage = nasaData.first {
                    self.dayPictureDelegate?.didUpdatуHeader(self, model: firstImage)
                    self.dayPictureDelegate?.didUpdateDayPicture(self, model: nasaData)
                } else {
                    self.dayPictureDelegate?.didUpdateDayPicture(self, model: nasaData)
                }
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    /// Fetch data for search view controller
    func fetchSearchResult(url: URL?, completion: @escaping (Result<Search, Error>) -> ()) {
        guard let url = url else {
            completion(.failure(NetworkError.badUrl))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                guard let response = response else { return }
                print(response)
                if let error = error {
                    completion(.failure(error))
                } else {
                    let error = NetworkError.badResponse
                    completion(.failure(error))
                }
                return
            }
            do {
                let searchData = try self.decoder.decode(Search.self, from: data)
                let searchResult = searchData.collection.items
                self.searchResultDelegate?.didUpdateSearchResult(self, model: searchResult)
            } catch {
                print("Ошибка декодирования JSON: \(error)")
            }
        }.resume()
    }
    
    /// Fetch data if image not in cache
    func fetchImage(withURL url: URL, completion: @escaping (Result<UIImage, Error>) -> ()) {
        if let cachedImage = ImageCache.shared.getImage(for: url.absoluteString as NSString) {
            completion(.success(cachedImage))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                let error = NSError(domain: "com.example.NASA", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to decode image data"])
                completion(.failure(error))
                return
            }
            
            ImageCache.shared.cacheImage(image: image, for: url.absoluteString as NSString)
            completion(.success(image))
        }.resume()
    }
}

enum NetworkError: Error {
    
    case badUrl
    case badRequest
    case badResponse
}
