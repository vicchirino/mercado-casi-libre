//
//  NetworkingError.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 28/07/2022.
//

import Foundation

enum CustomError: Error {
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
        case .invalidURL:
            return "Couldn't build the URL."
        case .fetchingError:
            return "Fialed when fetching the API."
        case .dataCorrupted:
            return "Failed when getting Data."
        case .decodingError:
            return "Failed to decode data."
        case .unexpected(_):
            return "An unexpected error occurred."
        }
    }
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notFound:
            return NSLocalizedString("The specified item could not be found.", comment: "Resource not found")
        case .invalidURL:
            return NSLocalizedString("Couldn't build the URL", comment: "Invalid url")
        case .fetchingError:
            return NSLocalizedString("Failed when fetching the API.", comment: "Fetching error")
        case .dataCorrupted:
            return NSLocalizedString("Failed when getting Data.", comment: "Data corrupted")
        case .decodingError:
            return NSLocalizedString("Failed to decode data.", comment: "Decoding error")
        case .unexpected(_):
            return NSLocalizedString("An unexpected error occurred.", comment: "Unexpected error")
        }
    }
}
