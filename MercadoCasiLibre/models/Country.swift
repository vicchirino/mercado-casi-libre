//
//  Country.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 22/07/2022.
//

import Foundation
import Combine

struct Country: Decodable {
    var id: String
    var name: String
    var locale: String
}
