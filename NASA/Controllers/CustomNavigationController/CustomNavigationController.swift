//
//  CustomNavigationController.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    //MARK: - Private method
    
    private func setupLeftBarButtonItem(for viewControllers: UIViewController) {
        let backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonTapped))
        
        backBarButtonItem.tintColor = .white
        viewControllers.navigationItem.leftBarButtonItem = backBarButtonItem
        navigationBar.prefersLargeTitles = false
    }
    
    @objc func backButtonTapped() {
        popViewController(animated: true)
    }
}

extension CustomNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is DayPictureViewController {
            setNavigationBarHidden(false, animated: true)
        }
        
        if !(viewController is DayPictureViewController) {
            setupLeftBarButtonItem(for: viewController)
        }
    }
}
