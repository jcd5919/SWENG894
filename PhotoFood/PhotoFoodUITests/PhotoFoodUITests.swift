//
//  PhotoFoodUITests.swift
//  PhotoFoodUITests
//
//  Created by Joseph Duckwall on 10/17/24.
//

import XCTest

final class PhotoFoodUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAllElementsExist() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        //This test verifies that when launching the application, all of the
        //expected UI items exist
        
        XCTAssert(app.staticTexts["Photo Your Food!"].exists)
        XCTAssert(app.staticTexts["Food Type"].exists)
        XCTAssert(app.staticTexts["Diet"].exists)
        XCTAssert(app.buttons["FoodFilter"].exists)
        XCTAssert(app.buttons["DietFilter"].exists)
        XCTAssert(app.buttons["Search"].exists)
        XCTAssert(app.buttons["Search by Photos"].exists)
        XCTAssert(app.buttons["My Recipes"].exists)
        XCTAssert(app.textFields["Ingredient 1"].exists)
        XCTAssert(app.textFields["Ingredient 2"].exists)
        XCTAssert(app.textFields["Ingredient 3"].exists)
        XCTAssert(app.textFields["Ingredient 4"].exists)
        
    }

    func testRecipesButton() throws {
        // UI tests must launch the application that they test.
        // This test verifies the functionality of the Favorites button, as well as the back button from
        // The list of favorites view.
        let app = XCUIApplication()
        app.launch()
        //Tap the favorites button which should take us to a page with header List of Favorites
        app.buttons["My Recipes"].tap()
        XCTAssertTrue(app.staticTexts["Recipes"].exists)
        //Now that we are on the list of favorites page, tap the navigation bar back button
        //and verify we go back to the original view
        app.navigationBars.buttons["Back"].tap()
        XCTAssertTrue(app.staticTexts["My Recipes"].exists)
        
    }
    
    func testTextFieldsAll() throws {
        // This test verifies the functionality of the ingredient textboxes on the screen.
        // It also ensures that typing in the textfields produces the expected result.
        let app = XCUIApplication()
        app.launch()
        let ingredient1Textfield = app.textFields["Ingredient 1"]
        let ingredient2Textfield = app.textFields["Ingredient 2"]
        let ingredient3Textfield = app.textFields["Ingredient 3"]
        let ingredient4Textfield = app.textFields["Ingredient 4"]
        
        //now tap each textfield and enter our test items
        ingredient1Textfield.tap()
        ingredient1Textfield.typeText("Blueberries")
        
        ingredient2Textfield.tap()
        ingredient2Textfield.typeText("Pie Dough")
        
        ingredient3Textfield.tap()
        ingredient3Textfield.typeText("Sugar")
        
        ingredient4Textfield.tap()
        ingredient4Textfield.typeText("Cream")
        
        //Now XCTestAssertEquals
        XCTAssertEqual(ingredient1Textfield.value as! String, "Blueberries")
        XCTAssertEqual(ingredient2Textfield.value as! String, "Pie Dough")
        XCTAssertEqual(ingredient3Textfield.value as! String, "Sugar")
        XCTAssertEqual(ingredient4Textfield.value as! String, "Cream")
    }
    
    func testFilterButtonsExist() throws {
        let app = XCUIApplication()
        app.launch()
        //This test verifies that the correct labels for the food and diet filters exists.
        //It also tests that the FoodFilter and DietFilter buttons exists
        
        //verify food and diet filter buttons/labels exist
        XCTAssert(app.buttons["FoodFilter"].exists)
        XCTAssert(app.buttons["DietFilter"].exists)
        XCTAssert(app.staticTexts["Food Type"].exists)
        XCTAssert(app.staticTexts["Diet"].exists)
    }
    
    func testFoodFilterSelectionBreakfast() throws {
        let app = XCUIApplication()
        app.launch()
        //This test verifies that for a single tap, the correct food filter is chosen
        
        //Verify that Breakfast is not currently selected
        XCTAssertFalse(app.staticTexts["Breakfast"].exists)
        //Verify that None is currently selected
        XCTAssertTrue(app.staticTexts["None"].exists)
        //Select the food filter
        let foodFilterButton = app.buttons["FoodFilter"]
        foodFilterButton.tap()
        app.buttons["Breakfast"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssertTrue(app.staticTexts["Breakfast"].exists)
    }

    func testFoodFilterSelectionMultiple() throws {
        let app = XCUIApplication()
        app.launch()
        
        //This test goes through each of the potential food filters and selects them, verifying that the correct
        //one is chosen when tapped
        
        //Verify that None is currently selected
        XCTAssertTrue(app.staticTexts["None"].exists)
        //Select the food filter
        let foodFilterButton = app.buttons["FoodFilter"]
        //Tap breakfast and confirm it becomes selected
        foodFilterButton.tap()
        app.buttons["Breakfast"].tap()
        sleep(2)
        //Assert that each food filter type button exists
        XCTAssertTrue(app.staticTexts["Breakfast"].exists)
        
        //Repeat the above process, but for Lunch, Dinner, and Dessert
        foodFilterButton.tap()
        app.buttons["Lunch"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssertTrue(app.staticTexts["Lunch"].exists)
        
        foodFilterButton.tap()
        app.buttons["Dinner"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssertTrue(app.staticTexts["Dinner"].exists)
        
        foodFilterButton.tap()
        app.buttons["Dessert"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssertTrue(app.staticTexts["Dessert"].exists)
    }
    
    func testDietFilterSelectionVegan() throws {
        let app = XCUIApplication()
        app.launch()
        //This test verifies that for a single tap, the correct food filter is chosen
        
        //Verify that Breakfast is not currently selected
        XCTAssertFalse(app.staticTexts["Vegan"].exists)
        //Verify that None is currently selected
        XCTAssertTrue(app.staticTexts["None"].exists)
        //Select the food filter
        let dietFilterButton = app.buttons["DietFilter"]
        dietFilterButton.tap()
        app.buttons["Vegan"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssert(app.staticTexts["Vegan"].exists)
    }

    func testDietFilterSelectionMultiple() throws {
        let app = XCUIApplication()
        app.launch()
        
        //This test goes through each of the potential food filters and selects them, verifying that the correct
        //one is chosen when tapped
        
        //Verify that None is currently selected
        XCTAssertTrue(app.staticTexts["None"].exists)
        //Select the food filter
        let dietFilterButton = app.buttons["DietFilter"]
        //Tap breakfast and confirm it becomes selected
        dietFilterButton.tap()
        app.buttons["Gluten-Free"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssertTrue(app.staticTexts["Gluten-Free"].exists)
        
        //Repeat the above process, but for Lunch, Dinner, and Dessert
        dietFilterButton.tap()
        app.buttons["Vegan"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssert(app.staticTexts["Vegan"].exists)
        
        dietFilterButton.tap()
        app.buttons["Vegetarian"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssert(app.staticTexts["Vegetarian"].exists)
        
        dietFilterButton.tap()
        app.buttons["Dairy-Free"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssert(app.staticTexts["Dairy-Free"].exists)
    }
    
    func testURLRequestSuccess() throws {
        let app = XCUIApplication()
        app.launch()
        
        let ingredient1Textfield = app.textFields["Ingredient 1"]
        let ingredient2Textfield = app.textFields["Ingredient 2"]
        let ingredient3Textfield = app.textFields["Ingredient 3"]
        let ingredient4Textfield = app.textFields["Ingredient 4"]
        
        //now tap each textfield and enter our test items
        ingredient1Textfield.tap()
        ingredient1Textfield.typeText("Blueberries")
        
        ingredient2Textfield.tap()
        ingredient2Textfield.typeText("Pie Dough")
        
        ingredient3Textfield.tap()
        ingredient3Textfield.typeText("Sugar")
        
        ingredient4Textfield.tap()
        ingredient4Textfield.typeText("Cream")
        
        app.buttons["Search"].tap()
        //Assert that we are now on the search results page.
        XCTAssert(app.staticTexts["Search Results"].exists)
        
        //Count the number of result and confirm that there are 20 result boxes
            
    }
    
    func testAddButtonExists() throws {
        let app = XCUIApplication()
        app.launch()
        
        let favoritesButton = app.buttons["My Recipes"]
        
        favoritesButton.tap()
        let rightNavBarButton = XCUIApplication().navigationBars.buttons["Add"]
        XCTAssertTrue(rightNavBarButton.exists)
    }
    
    func testAddRecipeNavigation() throws {
        let app = XCUIApplication()
        app.launch()
        
        let recipesButton = app.buttons["My Recipes"]
        
        recipesButton.tap()
        let rightNavBarButton = XCUIApplication().navigationBars.buttons["Add"]
        rightNavBarButton.tap()
        
        //Assert we are now in the add recipe view
        XCTAssert(app.staticTexts["Recipe Details"].exists)
        
        let cancelButton = XCUIApplication().navigationBars.buttons["Cancel"]
        XCTAssert(cancelButton.exists)
        cancelButton.tap()
        XCTAssert(app.staticTexts["Recipes"].exists)
    }
    
    func testAddRecipeElementsExist() throws {
        let app = XCUIApplication()
        app.launch()
        
        let recipesButton = app.buttons["My Recipes"]
        
        recipesButton.tap()
        let rightNavBarButton = XCUIApplication().navigationBars.buttons["Add"]
        rightNavBarButton.tap()
        
        //Assert we are now in the add recipe view
        XCTAssert(app.staticTexts["Recipe Details"].exists)
        //This test verifies that when launching the application, all of the
        //expected UI items exist
        
        let saveButton = XCUIApplication().navigationBars.buttons["Save"]
        XCTAssert(saveButton.exists)
        XCTAssert(app.textFields["Recipe Name"].exists)

    }
   
    func testFilterButtonsExistPhotoSearch() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Search by Photos"].tap()
        app.buttons["Library"].tap()
        XCTAssertTrue(app.buttons["Cancel"].waitForExistence(timeout: 3))
        let chocolateCake = NSPredicate(format: "label LIKE 'Screenshot, December 02, *:47*'")
        let activeQuery = chocolateCake
        app.scrollViews.otherElements.images.matching(activeQuery).element.tap()
        sleep(3)
        app.buttons["Okay"].tap()
        //This test verifies that the correct labels for the food and diet filters exists.
        //It also tests that the FoodFilter and DietFilter buttons exists
        
        //verify food and diet filter buttons/labels exist
        XCTAssertTrue(app.buttons["FoodFilter"].exists)
        XCTAssertTrue(app.buttons["DietFilter"].exists)
        XCTAssertTrue(app.staticTexts["Food Type"].exists)
        XCTAssertTrue(app.staticTexts["Diet"].exists)
    }
    
    func testFoodFilterSelectionBreakfastPhotoSearch() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Search by Photos"].tap()
        app.buttons["Library"].tap()
        XCTAssertTrue(app.buttons["Cancel"].waitForExistence(timeout: 3))
        let chocolateCake = NSPredicate(format: "label LIKE 'Screenshot, December 02, *:47*'")
        let activeQuery = chocolateCake
        app.scrollViews.otherElements.images.matching(activeQuery).element.tap()
        sleep(3)
        app.buttons["Okay"].tap()
        //This test verifies that for a single tap, the correct food filter is chosen
        
        //Verify that Breakfast is not currently selected
        XCTAssertFalse(app.staticTexts["Breakfast"].exists)
        //Verify that None is currently selected
        XCTAssertTrue(app.staticTexts["None"].exists)
        //Select the food filter
        let foodFilterButton = app.buttons["FoodFilter"]
        foodFilterButton.tap()
        app.buttons["Breakfast"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssertTrue(app.staticTexts["Breakfast"].exists)
    }

    func testFoodFilterSelectionMultiplePhotoSearch() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Search by Photos"].tap()
        app.buttons["Library"].tap()
        XCTAssertTrue(app.buttons["Cancel"].waitForExistence(timeout: 3))
        let chocolateCake = NSPredicate(format: "label LIKE 'Screenshot, December 02, *:47*'")
        let activeQuery = chocolateCake
        app.scrollViews.otherElements.images.matching(activeQuery).element.tap()
        sleep(3)
        app.buttons["Okay"].tap()
        //This test goes through each of the potential food filters and selects them, verifying that the correct
        //one is chosen when tapped
        
        //Verify that None is currently selected
        XCTAssertTrue(app.staticTexts["None"].exists)
        //Select the food filter
        let foodFilterButton = app.buttons["FoodFilter"]
        //Tap breakfast and confirm it becomes selected
        foodFilterButton.tap()
        app.buttons["Breakfast"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssert(app.staticTexts["Breakfast"].exists)
        
        //Repeat the above process, but for Lunch, Dinner, and Dessert
        foodFilterButton.tap()
        app.buttons["Lunch"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssert(app.staticTexts["Lunch"].exists)
        
        foodFilterButton.tap()
        app.buttons["Dinner"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssert(app.staticTexts["Dinner"].exists)
        
        foodFilterButton.tap()
        app.buttons["Dessert"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssert(app.staticTexts["Dessert"].exists)
    }
    
    func testDietFilterSelectionVeganPhotoSearch() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Search by Photos"].tap()
        app.buttons["Library"].tap()
        XCTAssertTrue(app.buttons["Cancel"].waitForExistence(timeout: 3))
        let chocolateCake = NSPredicate(format: "label LIKE 'Screenshot, December 02, *:47*'")
        let activeQuery = chocolateCake
        app.scrollViews.otherElements.images.matching(activeQuery).element.tap()
        sleep(3)
        app.buttons["Okay"].tap()
        //This test verifies that for a single tap, the correct food filter is chosen
        
        //Verify that Breakfast is not currently selected
        XCTAssertFalse(app.staticTexts["Vegan"].exists)
        //Verify that None is currently selected
        XCTAssertTrue(app.staticTexts["None"].exists)
        //Select the food filter
        let dietFilterButton = app.buttons["DietFilter"]
        dietFilterButton.tap()
        app.buttons["Vegan"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssertTrue(app.staticTexts["Vegan"].exists)
    }

    func testDietFilterSelectionMultiplePhotoSearch() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Search by Photos"].tap()
        app.buttons["Library"].tap()
        XCTAssertTrue(app.buttons["Cancel"].waitForExistence(timeout: 3))
        let chocolateCake = NSPredicate(format: "label LIKE 'Screenshot, December 02, *:47*'")
        let activeQuery = chocolateCake
        app.scrollViews.otherElements.images.matching(activeQuery).element.tap()
        sleep(3)
        app.buttons["Okay"].tap()
        //This test goes through each of the potential food filters and selects them, verifying that the correct
        //one is chosen when tapped
        
        //Verify that None is currently selected
        XCTAssertTrue(app.staticTexts["None"].exists)
        //Select the food filter
        let dietFilterButton = app.buttons["DietFilter"]
        //Tap breakfast and confirm it becomes selected
        dietFilterButton.tap()
        app.buttons["Gluten-Free"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssertTrue(app.staticTexts["Gluten-Free"].exists)
        
        //Repeat the above process, but for Lunch, Dinner, and Dessert
        dietFilterButton.tap()
        app.buttons["Vegan"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssertTrue(app.staticTexts["Vegan"].exists)
        
        dietFilterButton.tap()
        app.buttons["Vegetarian"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssertTrue(app.staticTexts["Vegetarian"].exists)
        
        dietFilterButton.tap()
        app.buttons["Dairy-Free"].tap()
        //Assert that each food filter type button exists
        sleep(2)
        XCTAssertTrue(app.staticTexts["Dairy-Free"].exists)
    }
 
    func testChoosingFromLibrary() throws {
        // ... test setup and navigation to get to presented Camera Roll (PHPicker or UIImagePickerController)
        // trigger presentation of camera roll
        let app = XCUIApplication()
        app.buttons["Search by Photos"].tap()
        app.buttons["Library"].tap()
        XCTAssertTrue(app.buttons["Cancel"].waitForExistence(timeout: 3))
        let chocolateCake = NSPredicate(format: "label LIKE 'Screenshot, December 02, *:47*'")
        let activeQuery = chocolateCake
        app.scrollViews.otherElements.images.matching(activeQuery).element.tap()
        sleep(3)
        app.buttons["Okay"].tap()
        XCTAssertTrue(app.staticTexts["chocolate_cake"].exists)
    }
}
