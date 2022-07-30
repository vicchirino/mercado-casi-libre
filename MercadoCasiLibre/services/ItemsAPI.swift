//
//  ItemAPI.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 28/07/2022.
//

import Foundation

protocol ItemsAPI {
    func getItems(ids: [String], completion: @escaping ([Item]?, CustomError?) -> Void)
    func getItemsDescription(ids: [String], completion: @escaping (ItemsDescriptionResponse?, CustomError?) -> Void)
}

struct ItemsRequest: Request {    
    typealias ModelType = [Item]
    
    var path = "/items"
    var httpMethod = HTTPMethod.get
    var parameters: [String : Any]?
    
    func decode(data: Data, completion: ([Item]?, CustomError?) -> Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let itemsResponses = try jsonDecoder.decode([ItemsResponse].self, from: data)
            completion(itemsResponses.map { $0.body }, nil)
        } catch {
            completion(nil, .decodingError)
        }
    }
}

struct ItemsDescriptionRequest: Request {
    typealias ModelType = ItemsDescriptionResponse
    
    var path: String
    var httpMethod = HTTPMethod.get
    var parameters: [String : Any]?
    
    func decode(data: Data, completion: (ItemsDescriptionResponse?, CustomError?) -> Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let itemDescriptionResponse = try jsonDecoder.decode(ItemsDescriptionResponse.self, from: data)
            completion(itemDescriptionResponse, nil)
        } catch {
            completion(nil, .decodingError)
        }
    }
}
