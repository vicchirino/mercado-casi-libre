//
//  Item.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 21/07/2022.
//

import Foundation

struct ItemsResponse: Decodable {
    var items: [ItemTest]
}

struct ItemTest: Decodable {
    var id: Int?
    var title: String
    var price: String
    var imageURL: String
    
    static func getMockItems() -> [ItemTest] {
        guard let path = Bundle.main.url(forResource: "mockItems", withExtension:"plist") else {
            fatalError("Can't find the json path")
        }
        do {
            let data = try Data(contentsOf: path)
            let items = try PropertyListDecoder().decode([ItemTest].self, from: data)
            return items
        } catch {
            fatalError("Can't get data from file")
        }
    }
}

struct Item: Decodable {
    var id: String
    var siteId: String
    var title: String
    var price: Float
    var currencyId: String
    var thumbnail: String
}



