//
//  NetworkingError.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 28/07/2022.
//

import Foundation

enum CustomError: Error {
    /// Throw when there is no internet coennction
    case noNetworkConnection
    /// Throw when an expected resource is not found
    case notFound
    /// Throw when couldn't build URL
    case invalidURL
    /// Throw when fetching the API
    case fetchingError
    /// Throw when reading Data
    case dataCorrupted
    /// Throw when decoding API fail
    case decodingError
    /// Throw when feature is not available
    case featureUnavailable
    /// Throw in all other cases
    case unexpected(code: Int)
}

extension CustomError {
    var isFatal: Bool {
        if case .unexpected = self { return true }
        return false
    }
}

extension CustomError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .notFound:
            return "The specified item could not be found."
        case .noNetworkConnection:
            return "There is not network connection"
        case .invalidURL:
            return "Couldn't build the URL."
        case .fetchingError:
            return "Fialed when fetching the API."
        case .dataCorrupted:
            return "Failed when getting Data."
        case .decodingError:
            return "Failed to decode data."
        case .featureUnavailable:
            return "Feature not available."
        case .unexpected(_):
            return "An unexpected error occurred."
        }
    }
}

extension CustomError: LocalizedError {
    /// I will be using this description for displaying on the UI
    public var errorDescription: String? {
        switch self {
        case .notFound:
            return NSLocalizedString("No se encontro lo solicitado.", comment: "Resource not found")
        case .noNetworkConnection:
            return NSLocalizedString("No hay conexion", comment: "Not network coennection")
        case .invalidURL:
            return NSLocalizedString("Algo salio mal ...", comment: "Invalid url")
        case .fetchingError:
            return NSLocalizedString("Algo salio mal ...", comment: "Fetching error")
        case .dataCorrupted:
            return NSLocalizedString("Algo salio mal ...", comment: "Data corrupted")
        case .decodingError:
            return NSLocalizedString("Algo salio mal ...", comment: "Decoding error")
        case .featureUnavailable:
            return NSLocalizedString("Modulo no disponible todavia", comment: "Feature not available")
        case .unexpected(_):
            return NSLocalizedString("Algo salio mal ...", comment: "Unexpected error")
        }
    }
}
