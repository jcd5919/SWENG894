//
//  SearchViewPresenterTest.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 10/8/24.
//

import XCTest

@testable import PhotoFood

final class SearchViewPresenterTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBasicCreateSearch() throws {
        let test = createSearch(ingredient1: "apples", ingredient2: "pie crust", ingredient3: "cinammon")
        XCTAssertEqual(test, "apples pie curst cinammon recipe")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
