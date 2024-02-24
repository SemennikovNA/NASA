//
//  ImageCache.swift
//  NASA
//
//  Created by Nikita on 10.02.2024.
//

import UIKit

final class ImageCache {
    
    //MARK: - Singleton
    
    static let shared = ImageCache()
    
    //MARK: - Properties
    
    private let cache = NSCache<NSString, UIImage>()
    
    //MARK: - Initialize
    
    private init() {}
    
    //MARK: - Method
    /// Method for save image in cache
    func cacheImage(image: UIImage, for key: NSString) {
        cache.setObject(image, forKey: key)
    }
    
    /// Method for get image from cache
    func getImage(for key: NSString) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
