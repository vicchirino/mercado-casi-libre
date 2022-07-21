//
//  Item.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 21/07/2022.
//

import Foundation


struct Item {
    var id: Int?
    var title: String
    var price: String
    var imageName: String
    
    
    static func getMockItems() -> [Item] {
        guard let path = Bundle.main.path(forResource: "mockItems", ofType: "json") else {
            fatalError("Can't find the json path")
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: [])
            print(jsonArray)
        } catch {
            fatalError("Can't get data from file")
        }
        return []
    }
}



