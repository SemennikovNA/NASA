//
//  UIViewController - Extension.swift
//  NASA
//
//  Created by Nikita on 09.02.2024.
//

import UIKit

extension UIViewController {
    
    
    /// Setup custom controllers for tab bar controller
    func setupViewControllers(viewController: UIViewController, title: String, image: String, selectedImage: String) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(systemName: image)
        viewController.tabBarItem.selectedImage = UIImage(systemName: selectedImage)
        return viewController
    }

}
