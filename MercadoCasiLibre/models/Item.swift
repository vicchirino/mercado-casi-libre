//
//  Item.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 21/07/2022.
//

import Foundation

struct Item: Decodable {
    var id: String
    var siteId: String
    var title: String
    var price: Float
    var currencyId: String
    var thumbnail: String
}



