//
//  ItemsAPITests.swift
//  MercadoCasiLibreTests
//
//  Created by Victor Chirino on 28/07/2022.
//

import XCTest

class ItemsAPITests: XCTestCase {
    
    var webService: WebService!
    var itemsRequest: ItemsRequest!
    var items: [Item]?
    var customError: CustomError?
    
    override func setUpWithError() throws {
        webService = WebService()
        itemsRequest = ItemsRequest()
    }

    override func tearDownWithError() throws {
        webService = nil
        itemsRequest = nil
        items = nil
        customError = nil
    }

    func testItemsRequestDecodeSuccess() throws {
        let mockedItemsData = mockContentData(withName: "ItemsMocked")

        // Create an expectation
        let expectation = self.expectation(description: "Decoding countries")
        
        itemsRequest.decode(data: mockedItemsData) { result, error in
            customError = error
            items = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        
        XCTAssertEqual(items?.count, 2)
        
        let firstItem = try XCTUnwrap(items?[0])
        XCTAssertEqual(firstItem.availableQuantity, 50)
        XCTAssertEqual(firstItem.soldQuantity, 2)
        XCTAssertEqual(firstItem.condition, "Nuevo")
        
        let picturesCount = try XCTUnwrap(firstItem.pictures.count)
        XCTAssertGreaterThan(picturesCount, 0)
        
        let firstPicture = try XCTUnwrap(firstItem.pictures[0])

        XCTAssertEqual(firstPicture.maxSize, "1200x600")
        XCTAssertEqual(firstPicture.size, "500x250")
        XCTAssertEqual(firstPicture.url, "https://item-1-picture-1")

        XCTAssertNil(customError)
    }
    
    func testItemshRequestDecodeError() throws {
        let expectation = self.expectation(description: "Decoding search")
        
        itemsRequest.decode(data: Data()) { result, error in
            customError = error
            items = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertEqual(customError?.description, CustomError.decodingError.description)
        XCTAssertNil(items)
    }
    
    func testItemsRequest() throws {
        XCTAssertEqual(itemsRequest.path, "/items")
        XCTAssertEqual(itemsRequest.httpMethod.rawValue, "GET")
    }
    
    func testItemsAPIgetItems() throws {
        let expectation = self.expectation(description: "Fetch countries API")
        
        webService.search(q: "Monkey Island", offset: 0) { [weak self] searchResult, _ in
            let firstItem = searchResult.results[0]
            
            self?.webService.getItems(ids: [firstItem.id]) { [weak self] itemsResult, customErrorResult in
                self?.items = itemsResult
                self?.customError = customErrorResult
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10)
        
        XCTAssertNil(customError)
        let itemsCount = try XCTUnwrap(items?.count)
        let item = try XCTUnwrap(items?[0])
        XCTAssertNotNil(item)
        XCTAssertGreaterThan(itemsCount, 0)
    }

}
