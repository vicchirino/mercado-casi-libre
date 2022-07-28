//
//  SearchAPITests.swift
//  MercadoCasiLibreTests
//
//  Created by Victor Chirino on 28/07/2022.
//

import XCTest

class SearchAPITests: XCTestCase {
    
    var webService: WebService!
    var searchRequest: SearchRequest!
    var search: Search?
    var customError: CustomError?
    
    override func setUpWithError() throws {
        searchRequest = SearchRequest()
        webService = WebService()
    }

    override func tearDownWithError() throws {
        searchRequest = nil
        webService = nil
        search = nil
        customError = nil
    }

    func testSearchRequestDecodeSuccess() throws {
        let mockedSearchData = mockContentData(withName: "SearchMocked")

        // Create an expectation
        let expectation = self.expectation(description: "Decoding search")
        
        searchRequest.decode(data: mockedSearchData) { result, error in
            customError = error
            search = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        
        XCTAssertEqual(search?.paging.total, 3)
        XCTAssertEqual(search?.results.count, 3)
        XCTAssertEqual(search?.query, "Monkey Island")
        XCTAssertEqual(search?.siteId, "MLA")
        
        let firstItem = try XCTUnwrap(search?.results[0])
        XCTAssertEqual(firstItem.title, "The Secret of Monkey Island")
        XCTAssertEqual(firstItem.price, 1200)

        XCTAssertNil(customError)
    }
    
    func testSearchRequestDecodeError() throws {
        let expectation = self.expectation(description: "Decoding search")
        
        searchRequest.decode(data: Data()) {[weak self] result, error in
            self?.customError = error
            self?.search = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertEqual(customError?.description, CustomError.decodingError.description)
        XCTAssertNil(search)
        
    }
    
    func testSearchReques() throws {
        XCTAssertEqual(searchRequest.path, "/sites/MLA/search")
        XCTAssertEqual(searchRequest.httpMethod.rawValue, "GET")
    }
    
    func testSearchAPIWithoutParameters() throws {
        let expectation = self.expectation(description: "Fetch search API")
        
        webService.search {[weak self] searchResult, customErrorResult in
            self?.search = searchResult
            self?.customError = customErrorResult
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10)
        XCTAssertNil(customError)
        XCTAssertNil(search?.query)
        XCTAssertEqual(search?.siteId, "MLA")
    }
    
    func testSearchAPIWithParameters() throws {
        let expectation = self.expectation(description: "Fetch search API")
        
        webService.search(q: "Monkey Island") { [weak self] searchResult, customErrorResult in
            self?.search = searchResult
            self?.customError = customErrorResult
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        XCTAssertNil(customError)
        XCTAssertEqual(search?.query, "Monkey Island")
        XCTAssertEqual(search?.siteId, "MLA")
    }


}
