//
//  WebService2.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 27/07/2022.
//

import Foundation

protocol Request {
    associatedtype ModelType: Decodable
    var path: String { get set }
    var httpMethod: HTTPMethod { get set }
    var parameters: [String : Any]? { get set}
    
    func decode(data: Data) -> ModelType
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
public final class WebService {
    
    private var baseURL = "https://api.mercadolibre.com"
    var urlRequest: URLRequest!

    private func configureHeaders() {
        urlRequest.setValue("Bearer \("$ACCESS_TOKEN")", forHTTPHeaderField: "Authentication")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    private func configure(_ parameters: [String: Any]?) throws {
        guard let parameters = parameters else {
            return
        }
        guard let url = urlRequest.url?.absoluteString, var urlComponents = URLComponents(string: url) else {
            throw NetworkingError.invalidURL
        }
        urlComponents.queryItems = []
        _ = parameters.map { (key, value) in
            let item = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(item)
        }
        urlRequest.url =  urlComponents.url
    }
    
    private func fetch<T: Request>(request: T, completion: @escaping (T.ModelType?, NetworkingError?) -> Void) {
        guard let url = URL(string: baseURL + request.path) else {
            DispatchQueue.main.async {
                completion(nil, NetworkingError.invalidURL)
            }
            return
        }
             
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        configureHeaders()
        
        do {
            try configure(request.parameters)
        } catch {
            DispatchQueue.main.async {
                completion(nil, NetworkingError.invalidURL)
            }
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil, NetworkingError.fetchingError)
                }
            }
            
            // Check response status code to handle other errors
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, NetworkingError.dataCorrupted)
                }
                return
            }
            DispatchQueue.main.async {
                completion(request.decode(data: data), nil)
            }
        }.resume()
    }
}

// MARK: - SearchAPI
extension WebService: SearchAPI {
    func search(q: String = "", offset: Int = 0, completion: @escaping (Search, NetworkingError?) -> Void) {
        let searchRequest = SearchRequest(parameters: ["q": q, "offset": offset])
        fetch(request: searchRequest) { result, error in
            completion(result ?? Search.placeHolder(), error)
        }
    }
}

// MARK: - CountriesAPI
extension WebService: CountriesAPI {
    func getCountries(completion: @escaping (([Country]?, NetworkingError?) -> Void)) {
        let countriesRequest = CountriesRequest()
        fetch(request: countriesRequest, completion: completion)
    }
}





