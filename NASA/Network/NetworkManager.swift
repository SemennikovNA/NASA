//
//  NetworkManager.swift
//  NASA
//
//  Created by Nikita on 10.02.2024.
//

import UIKit

protocol NetworkManagerDelegate {
    func didUpdateDayPicture(_ networkManager: NetworkManager, model: [DayPictureModel])
    func didFailWithError(_ error: Error)
}

class NetworkManager {
    
    //MARK: - Properties
    
    static let shared = NetworkManager()
    private let decoder = JSONDecoder()
    private let session = URLSession(configuration: .default)
    private let apiKey = "UU3VJDZp0yuGErh0Qc2H5Xrj9AvbjRlt9tjDUS44"
    var delegate: NetworkManagerDelegate?
    
    
    //MARK: - Initialize
    
    private init(){}
    
    //MARK: - Method
    /// Create url depending on parameters
    func createURL(search: Bool = false, searchString: String = "", count: Int) -> URL? {
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
    func fetchData(count: Int, complition: @escaping (Result<DayPictureModel, Error>) -> ()) {
        guard let url = createURL(count: count) else {
            complition(.failure(NetworkError.badUrl))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            guard let data else {
                if let error {
                    complition(.failure(error))
                }
                return
            }
            do {
                let nasaData = try self.decoder.decode([DayPictureModel].self, from: data)
                self.delegate?.didUpdateDayPicture(self, model: nasaData)
            } catch {
                complition(.failure(error))
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
