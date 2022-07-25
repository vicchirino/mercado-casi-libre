//
//  Account.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 25/07/2022.
//

import Foundation

struct Account {
    var id: Int
    var userId: Int
    var streetNumber: String
    var streetName: String
    var zipCode: String
    var city: City
    
    struct City {
        var id: String
        var name: String
    }
}
