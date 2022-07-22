//
//  Site.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 22/07/2022.
//

import Foundation
import Combine

struct Site: Decodable {
    var id: String
    var name: String
    var currency: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case currency = "defaultCurrencyId"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        currency = try values.decode(String.self, forKey: .currency)
    }
}
