//
//  Item.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 21/07/2022.
//

import Foundation

struct ItemsResponse: Decodable {
    var items: [Item]
}


struct Item: Decodable {
    var id: Int?
    var title: String
    var price: String
    var imageURL: String
    
    
    static func getMockItems() -> [Item] {
        guard let path = Bundle.main.url(forResource: "mockItems", withExtension:"plist") else {
            fatalError("Can't find the json path")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let items = try PropertyListDecoder().decode([Item].self, from: data)
            return items
        } catch {
            fatalError("Can't get data from file")
            return []
        }
    }
}



