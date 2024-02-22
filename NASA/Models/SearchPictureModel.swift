//
//  SearchPictureModel.swift
//  NASA
//
//  Created by Nikita on 22.02.2024.
//

import Foundation

struct SearchPictureModel: Codable {
    let collection: Collection
}

struct Collection: Codable {
    let items: [Items]
}

struct Items: Codable {
    let data: [data]
    let links: [Links]
}

struct data: Codable {
    let title: String
}

struct Links: Codable {
    let href: String
}
