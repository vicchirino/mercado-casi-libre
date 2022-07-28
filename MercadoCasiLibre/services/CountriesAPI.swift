//
//  CountriesAPI.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 27/07/2022.
//

import Foundation

protocol CountriesAPI {
    func getCountries(completion: @escaping (([Country]?, NetworkingError?) -> Void))
}

struct CountriesRequest: Request {
    typealias ModelType = [Country]
    
    var path = "/classified_locations/countries"
    var httpMethod = HTTPMethod.get
    var parameters: [String : Any]?
    
    func decode(data: Data) -> [Country] {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let countries = try jsonDecoder.decode([Country].self, from: data)
            return countries
        } catch {
            print("Handle decoding error")
            return []
        }
    }
}
