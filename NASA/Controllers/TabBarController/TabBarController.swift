//
//  TabBarController.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

final class TabBarController: UITabBarController {

    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Call method's
        setupTabBar()
    }
    
    //MARK: - Private method
    
    private func setupTabBar() {
        viewControllers = [setupViewControllers(viewController: DayPictureViewController(), title: "Фото дня", image: "photo", selectedImage: "photo.fill"), setupViewControllers(viewController: SearchViewController(), title: "Поиск", image: "magnifyingglass.circle", selectedImage: "magnifyingglass.circle.fill")]
        setupTabBarApperance()
    }
    
    private func setupTabBarApperance() {
        let apperance = UITabBarAppearance()
        apperance.backgroundColor = .black
        tabBar.standardAppearance = apperance
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .lightGray
    }
    
    private func setupViewControllers(viewController: UIViewController, title: String, image: String, selectedImage: String) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(systemName: image)
        viewController.tabBarItem.selectedImage = UIImage(systemName: selectedImage)
        return viewController
    }
}

