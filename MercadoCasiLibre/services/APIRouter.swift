//
//  APIRouter.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 22/07/2022.
//

import Alamofire
import Foundation

public protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: Parameters? { get }
    func asURLRequest() throws -> URLRequest
}

public enum APIRouter: APIConfiguration {
    case getSites
    case getCountries
    case getSearch(_ parameters: [String: String])
    
    // MARK: - HTTPMethod
    public var method: HTTPMethod {
        switch self {
        case .getCountries, .getSites, .getSearch:
            return .get
        }
    }
    
    // MARK: - BaseURL
    public var baseURL: String {
        return "https://api.mercadolibre.com"
    }
    
    // MARK: - Path
    public var path: String {
        switch self {
        case .getCountries:
            return "/classified_locations/countries"
        case .getSites:
            return "/sites"
        case .getSearch:
            return "/sites/\(APIClient().site)/search"
        }
    }
    
    // MARK: - Parameters
    public var parameters: Parameters? {
        switch self {
        case .getCountries, .getSites:
            return nil
        case .getSearch(let parameters):
            return parameters
        }
    }
    
    // MARK: - URLRequestConvertible
    public func asURLRequest() throws -> URLRequest {
        let urlWithPathValue = baseURL + path
        var url: URL = try urlWithPathValue.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer \("$ACCESS_TOKEN")", forHTTPHeaderField: "Authentication")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let parameters = parameters {
            guard var urlComponents = URLComponents(string: urlWithPathValue) else {
                fatalError("Couldn't get URLComponents")
            }
                
            urlComponents.queryItems = []
            _ = parameters.map { (key, value) in
                let item = URLQueryItem(name: key, value: value as? String)
                urlComponents.queryItems?.append(item)
            }
            url = urlComponents.url ?? url
            urlRequest.url = url
        }

        return urlRequest
    }
}
