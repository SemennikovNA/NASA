//
//  UILabel - Extension.swift
//  NASA
//
//  Created by Nikita on 06.02.2024.
//

import UIKit

extension UILabel {
    
    convenience init(title: String? = "", font: UIFont, numberOfLines: Int = 1, textColor: UIColor ) {
        self.init()
        self.font = font
        self.text = title
        self.numberOfLines = numberOfLines
        self.textColor = textColor
    }
}
