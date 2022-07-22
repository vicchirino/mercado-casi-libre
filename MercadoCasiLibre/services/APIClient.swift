//
//  APIClient.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 22/07/2022.
//

import Foundation
import Alamofire
import Combine


protocol APICountriesProtocol: AnyObject {
    func getCountries(completion: @escaping (Result<[Country], AFError>) -> Void)
    func getCountriesWithCombine() -> AnyPublisher<Result<[Country], AFError>, Never>
}

protocol APISitesProtocol: AnyObject {
    func getSites(completion: @escaping (Result<[Site], AFError>) -> Void)
    func getSitesWithCombine() -> AnyPublisher<Result<[Site], AFError>, Never>
}

protocol APISearchProtocol: AnyObject {
    func getSearch(completion: @escaping (Result<Search, AFError>) -> Void)
    func getSearchWithCombine(q: String) -> AnyPublisher<Result<Search, AFError>, Never>
}


public final class APIClient {
    
    @discardableResult
    private func performRequest<T: Decodable>(route: APIRouter, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, AFError>) -> Void) -> DataRequest {
        return AF.request(route).responseDecodable(of: T.self, decoder: decoder) { response in
            completion(response.result)
        }
    }
    
    private func performCombineRequest<T: Decodable>(route: APIRouter, type: T.Type = T.self,decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Result<T, AFError>, Never> {
        return AF.request(route).publishDecodable(type: type, decoder: decoder).result()
    }
}

// MARK: - APICountriesProtocol
extension APIClient: APICountriesProtocol {
    func getCountries(completion: @escaping (Result<[Country], AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        performRequest(route: .getCountries, decoder: jsonDecoder, completion: completion)
    }
    
    func getCountriesWithCombine() -> AnyPublisher<Result<[Country], AFError>, Never> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return performCombineRequest(route: .getCountries, type: [Country].self, decoder: jsonDecoder)
    }
}

// MARK: - APISitesProtocol
extension APIClient: APISitesProtocol {
    func getSites(completion: @escaping (Result<[Site], AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        performRequest(route: .getSites, decoder: jsonDecoder, completion: completion)
    }
    
    func getSitesWithCombine() -> AnyPublisher<Result<[Site], AFError>, Never> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return performCombineRequest(route: .getSites, type: [Site].self, decoder: jsonDecoder)
    }
}


// MARK: - APISearchProtocol
extension APIClient: APISearchProtocol {
    func getSearch(completion: @escaping (Result<Search, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        performRequest(route: .getSearch(["q": "apple"]), decoder: jsonDecoder, completion: completion)
    }
    
    func getSearchWithCombine(q: String = "") -> AnyPublisher<Result<Search, AFError>, Never> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return performCombineRequest(route: .getSearch(["q" : q]), type: Search.self, decoder: jsonDecoder)
    }
}
