//
//  CountriesAPITests.swift
//  MercadoCasiLibreTests
//
//  Created by Victor Chirino on 28/07/2022.
//

import XCTest

class CountriesAPITests: XCTestCase {
    
    var countriesRequest: CountriesRequest!
    var countries: [Country]?
    var customError: CustomError?
    
    override func setUpWithError() throws {
        countriesRequest = CountriesRequest()
    }

    override func tearDownWithError() throws {
        countriesRequest = nil
        countries = nil
        customError = nil
    }

    func testSearchRequestDecodeSuccess() throws {
        let mockedCountriesData = mockContentData(withName: "CountriesMocked")

        // Create an expectation
        let expectation = self.expectation(description: "Decoding countries")
        
        countriesRequest.decode(data: mockedCountriesData) { result, error in
            customError = error
            countries = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        
        XCTAssertEqual(countries?.count, 3)
        
        let firstCountry = try XCTUnwrap(countries?[0])
        XCTAssertEqual(firstCountry.name, "Argentina")
        XCTAssertEqual(firstCountry.id, "AR")
        XCTAssertEqual(firstCountry.locale, "es_AR")

        XCTAssertNil(customError)
    }
    
    func testSearchRequestDecodeError() throws {
        let expectation = self.expectation(description: "Decoding search")
        
        countriesRequest.decode(data: Data()) { result, error in
            customError = error
            countries = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertEqual(customError?.description, CustomError.decodingError.description)
        XCTAssertNil(countries)
    }
    
    func testCountriesRequest() throws {
        XCTAssertEqual(countriesRequest.path, "/classified_locations/countries")
        XCTAssertEqual(countriesRequest.httpMethod.rawValue, "GET")
    }

}
