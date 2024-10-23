//
//  SearchPresenterTests.swift
//  PhotoFoodTests
//
//  Created by Joseph Duckwall on 10/18/24.
//

import XCTest
@testable import PhotoFood


final class SearchPresenterTests: XCTestCase, PresenterView {
    func updateSearchUI() {
    }
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }
    

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCreateSearch() throws {
        //This function tests that the createSearch function inside of SearchPresenter works as expected.
        let sp = PhotoFood.SearchPresenter(view: self)
        
        //Contruct our search with differnet ingredients
        let foodFilter = "Dessert"
        let typeFilter = "Dairy-Free"
        let ingredient1 = "Cherries"
        let ingredient2 = "Sugar"
        let ingredient3 = "OatMilk"
        let ingredient4 = "Flour"
        
        //create our string of the expected result
        let expectedResult = "Dessert+Dairy-Free+Cherries+Sugar+OatMilk+Flour+recipes"
        //verify that our functions matches the result that we expect
        let createSearchResult = sp.createSearch(foodFilter: foodFilter, typeFilter: typeFilter, ingredient1: ingredient1,
                                                 ingredient2: ingredient2, ingredient3: ingredient3, ingredient4: ingredient4)
        XCTAssertEqual(createSearchResult, expectedResult)
        
    }
    
    func testCreateSearchNoFilters() throws {
        let sp = PhotoFood.SearchPresenter(view: self)
        
        //Construct our search with neither filter used
        let ingredient1 = "Beef"
        let ingredient2 = "Onions"
        let ingredient3 = "Carrots"
        
        //create our expected results string
        let expectedResult = "Beef+Onions+Carrots+recipes"
        
        let createSearchResult = sp.createSearch(ingredient1: ingredient1, ingredient2: ingredient2, ingredient3: ingredient3)
        XCTAssertEqual(createSearchResult, expectedResult)
    }
    
    func testSearchButtonClicked() throws {
        let sp = PhotoFood.SearchPresenter(view: self)
        
        //Same idea as the above tests, confirm that the result of a createSearch call is saved to searchURL var of presenter
        sp.foodFilter = "Dinner"
        sp.ingredient1 = "Apples"
        sp.ingredient2 = "Pork"
        //Replicate the assignment of "" to other variables
        sp.typeFilter = "None"
        sp.ingredient3 = ""
        sp.ingredient4 = ""
        //call the searchButtonClicked function
        sp.searchButtonClicked()
        //Verify that the expected string of "Dinner+Apples+Pork+recipes is the variable in searchURL"
        XCTAssertEqual(sp.searchURL, "Dinner+Apples+Pork+recipes")
    }


}
