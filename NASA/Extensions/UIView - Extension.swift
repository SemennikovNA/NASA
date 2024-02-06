//
//  UIView - Extension.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

extension UIView {
    
    /// Add subview and off translates autoresizing mask into constraints
    func addSubviews(_ view: UIView...) {
        view.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
