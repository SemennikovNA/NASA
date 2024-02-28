//
//  SceneDelegate.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let dayPictureViewController = DayPictureViewController().setupViewControllers(viewController: DayPictureViewController(), title: "Фото дня", image: "photo", selectedImage: "photo.fill")
        let searchViewController = SearchViewController().setupViewControllers(viewController: SearchViewController(), title: "Поиск", image: "magnifyingglass.circle", selectedImage: "magnifyingglass.circle.fill")
        
        let firstNavigationController = setupNavBar(view: dayPictureViewController)
        let secondNavigationController = setupNavBar(view: searchViewController)
        
        let tabBarController = setupTabBar()
        tabBarController.viewControllers = [firstNavigationController, secondNavigationController]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    // Setup custom tab bar
    private func setupTabBar() -> UITabBarController{
        let tabBarController = UITabBarController()
        let apperance = UITabBarAppearance()
        apperance.backgroundColor = .black
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.tabBar.standardAppearance = apperance
        return tabBarController
    }
    
    // Setup custom navigation bar
    private func setupNavBar(view: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: view)
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.configureWithTransparentBackground()
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.barTintColor = .white
        return navigationController
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
