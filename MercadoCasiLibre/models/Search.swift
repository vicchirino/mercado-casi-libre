//
//  Search.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 22/07/2022.
//

import Foundation
import Combine

struct Search: Decodable {
    var siteId: String
    var countryDefaultTimeZone: String
//    var query: String
    var results: [Item]
}
