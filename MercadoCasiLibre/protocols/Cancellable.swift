//
//  Cancellable.swift
//  MercadoCasiLibre
//
//  Created by Victor Chirino on 21/07/2022.
//

import Foundation


protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable {
    
}
