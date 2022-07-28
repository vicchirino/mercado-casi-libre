//
//  SearchAPI.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 27/07/2022.
//

import Foundation

protocol SearchAPI {
    func search(q: String, offset: Int, completion: @escaping (Search) -> Void)
}

struct SearchRequest: Request {
    typealias ModelType = Search
    
    var path = "/sites/MLA/search"
    var httpMethod = HTTPMethod.get
    var parameters: [String : Any]?
    
    func decode(data: Data) -> Search {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let search = try jsonDecoder.decode(Search.self, from: data)
            return search
        } catch {
            print("Handle decoding error")
            return Search.placeHolder()
        }
    }
        
}
