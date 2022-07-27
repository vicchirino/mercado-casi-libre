//
//  WebService.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 27/07/2022.
//

import Foundation
import Combine

protocol WebServiceCountriesProtocol {
    func getCountries() -> AnyPublisher<[Country], Error>
}

protocol WebServiceSitesProtocol {
    func getSites() -> AnyPublisher<[Site], Error>
}


protocol WebServiceSearchProtocol {
    func search(q: String, offset: Int) -> AnyPublisher<Search, Error>
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public final class WebService {
    
    var baseURL = "https://api.mercadolibre.com"
    var site = "MLA"
    var urlRequest: URLRequest!

    private func configureHeaders() {
        urlRequest.setValue("Bearer \("$ACCESS_TOKEN")", forHTTPHeaderField: "Authentication")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    private func configure(_ parameters: [String: Any]) {
        guard let url = urlRequest.url?.absoluteString, var urlComponents = URLComponents(string: url) else {
            fatalError("Couldn't get URLComponents")
        }
        urlComponents.queryItems = []
        _ = parameters.map { (key, value) in
            let item = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(item)
        }
        urlRequest.url =  urlComponents.url
    }
    
    private func request<T: Decodable>(withPath path: String = "",
                                       httpMethod: HTTPMethod,
                                       andParameters parameters: [String: Any] = [:]) -> AnyPublisher<T, Error> {
        guard let url = URL(string: baseURL + path) else {
            fatalError("Cannot form URL")
        }
        
        urlRequest = URLRequest(url: url)
        
        configureHeaders()
        configure(parameters)
        
        urlRequest.httpMethod = httpMethod.rawValue
                
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .receive(on: RunLoop.main)
            .mapError({ error in
                fatalError("Error when fetching")
            })
            .map {  $0.data }
            .decode(type: T.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
    
}

// MARK: - WebServiceSearchProtocol
extension WebService: WebServiceSearchProtocol {
    func search(q: String, offset: Int) -> AnyPublisher<Search, Error> {
        return request(
            withPath: "/sites/\(site)/search",
            httpMethod: .get,
            andParameters: ["q": q, "offset": offset]) as AnyPublisher<Search, Error>
    }
}

// MARK: - WebServiceCountriesProtocol
extension WebService: WebServiceCountriesProtocol {
    func getCountries() -> AnyPublisher<[Country], Error> {
        return request(withPath: "/classified_locations/countries", httpMethod: .get)
    }
}

// MARK: - WebServiceSitesProtocol
extension WebService: WebServiceSitesProtocol {
    func getSites() -> AnyPublisher<[Site], Error> {
        return request(withPath: "/sites", httpMethod: .get)
    }
}

