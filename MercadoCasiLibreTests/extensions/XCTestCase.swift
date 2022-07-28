//
//  XCTestCase.swift
//  MercadoCasiLibreTests
//
//  Created by Victor Chirino on 28/07/2022.
//

import Foundation
import XCTest

extension XCTestCase {
        
    func mockContentData(withName name: String) -> Data {
        return getData(name: name)
    }

    func getData(name: String, withExtension: String = "json") -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let fileURL = bundle.url(forResource: name, withExtension: withExtension) else {
            fatalError("Could not find the content data")
        }
        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            fatalError("Could not encode content data")
        }
    }
}


