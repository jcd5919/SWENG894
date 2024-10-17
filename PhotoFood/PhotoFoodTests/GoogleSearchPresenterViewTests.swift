//
//  GoogleSearchPresenterViewTests.swift
//  PhotoFoodTests
//
//  Created by Joseph Duckwall on 10/8/24.
//

import XCTest
@testable import PhotoFood

final class GoogleSearchPresenterViewTests: XCTestCase {

    func createSearch(_ foodFilter: String = "", _ typeFilter: String = "", ingredient1: String, _ ingredient2: String = "", _ ingredient3: String = "", _ ingredient4: String = "")-> String {
       
        var search = "" + foodFilter
        if typeFilter != "" {
            search += typeFilter
        }
        search += ingredient1
        if ingredient2 != "" {
            search += "+" + ingredient2
        }
        if ingredient3 != "" {
            search += "+" + ingredient3
        }
        if ingredient4 != "" {
            search += "+" + ingredient4
        }
        search += "+recipes"
        
        return search
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBasicCreateSearch() throws {
        let test = createSearch(ingredient1: "apples", "pie dough", "cinnamon")
        XCTAssertEqual(test, "apples+pie+dough+cinnamon+recipes")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
