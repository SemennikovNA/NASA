//
//  NetworkManager.swift
//  NASA
//
//  Created by Nikita on 10.02.2024.
//

import Foundation

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
    
    func createURL(count: Int) -> URL? {
        let tunnel = "https://"
        let url = "api.nasa.gov/planetary/apod?"
        let countItem = "count=\(count)"
        let key = "&api_key=\(self.apiKey)"
        let string = tunnel + url + countItem + key
        let urlString = URL(string: string)
        return urlString
    }
    
    //MARK: - Private method
    
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
}


enum NetworkError: Error {
    
    case badUrl
    case badRequest
    case badResponse
}
