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
}

struct Item: Decodable {
    var id: String
    var siteId: String
    var title: String
    var price: Float
    var currencyId: String
    var thumbnail: String
}



