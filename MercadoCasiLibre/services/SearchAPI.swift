//
//  SearchAPI.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 27/07/2022.
//

import Foundation

protocol SearchAPI {
    func search(q: String, offset: Int, completion: @escaping (Search, CustomError?) -> Void)
}

struct SearchRequest: Request {
    typealias ModelType = Search
    
    var path = "/sites/MLA/search"
    var httpMethod = HTTPMethod.get
    var parameters: [String : Any]?
    
    func decode(data: Data, completion: (Search?, CustomError?) -> Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let search = try jsonDecoder.decode(Search.self, from: data)
            completion(search, nil)
        } catch {
            completion(nil, .decodingError)
        }
    }
        
}
