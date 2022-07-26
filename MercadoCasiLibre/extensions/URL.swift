//
//  URL.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 26/07/2022.
//

import Foundation

extension URL {
    func valueOf(_ queryParameterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParameterName })?.value
    }
}
