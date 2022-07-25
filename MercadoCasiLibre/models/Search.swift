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
    var query: String?
    var results: [Item]
    var paging: PagingInfo
    
    struct PagingInfo: Decodable {
        var total: Int
        var offset: Int
        var limit: Int
    }
    
    static func placeHolder() -> Search {
        return Search(siteId: "", countryDefaultTimeZone: "", query: "", results: [], paging: PagingInfo(total: 0, offset: 0, limit: 0))
    }
}
