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

struct ItemsDescriptionResponse: Decodable {
    var text: String
    enum CodingKeys: String, CodingKey {
        case text = "plainText"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decode(String.self, forKey: .text)
    }
}

struct Item: Decodable {
    let id: String
    let siteId: String
    let title: String
    let price: Float
    let currencyId: String
    let thumbnail: String
    let availableQuantity: Int
    let soldQuantity: Int
    let condition: String
    
    struct Picture: Decodable {
        let id: String
        let url: String
//        var size: String
//        var maxSize: String
    }
    
    var pictures: [Picture]
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case siteId
        case title
        case price
        case currencyId
        case thumbnail
        case availableQuantity
        case soldQuantity
        case condition
        case pictures
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        siteId = try values.decode(String.self, forKey: .siteId)
        title = try values.decode(String.self, forKey: .title)
        price = try values.decode(Float.self, forKey: .price)
        currencyId = try values.decode(String.self, forKey: .currencyId)
        thumbnail = try values.decode(String.self, forKey: .thumbnail)
        availableQuantity = try values.decode(Int.self, forKey: .availableQuantity)
        soldQuantity = try values.decode(Int.self, forKey: .soldQuantity)
        condition = try values.decode(String.self, forKey: .condition)
        var _pictures: [Picture]
        do {
            _pictures = try values.decode([Picture].self, forKey: .pictures)
        } catch {
            _pictures = []
        }
        pictures = _pictures
    }
    
}



