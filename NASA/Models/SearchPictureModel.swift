//
//  SearchPictureModel.swift
//  NASA
//
//  Created by Nikita on 22.02.2024.
//

import Foundation

struct Search: Codable {
    let collection: Collection
}

// MARK: - Collection
struct Collection: Codable {

    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let data: [Datum]
    let links: [Link]
}

// MARK: - Datum
struct Datum: Codable {
    let title: String
    
}

// MARK: - Link
struct Link: Codable {
    let href: String
}
