//
//  Item.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 21/07/2022.
//

import Foundation

struct ItemsResponse: Decodable {
    var code: Int
    var body: Item
}

struct Item: Decodable {
    var id: String
    var siteId: String
    var title: String
    var price: Float
    var currencyId: String
    var thumbnail: String
    var availableQuantity: Int
    var soldQuantity: Int
    var condition: String
    
    struct Picture: Decodable {
        var id: String
        var url: String
        var size: String
        var maxSize: String
    }
    
    var pictures: [Picture]?
    
}



