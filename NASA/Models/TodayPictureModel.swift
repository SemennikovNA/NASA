//
//  TodayPictureModel.swift
//  NASA
//
//  Created by Nikita on 25.02.2024.
//

import Foundation

struct TodayPictureModel: Codable {
    
    let copyright: String
    let explanation: String
    let title: String
    let url: String
    
    init(copyright: String, explanation: String, title: String, url: String) {
        self.copyright = copyright
        self.explanation = explanation
        self.title = title
        self.url = url
    }

}
