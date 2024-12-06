//
//  URecipesServiceTests.swift
//  PhotoFoodTests
//
//  Created by Joseph Duckwall on 11/1/24.
//

import XCTest
@testable import PhotoFood
import CoreData


final class URecipesServiceTests: XCTestCase {

    var recipeService: URecipesService!
    var coreDataStack: CoreDataStack!
    
    override func setUp() {
      super.setUp()
      coreDataStack = TestCoreDataStack()
      recipeService = URecipesService(
        managedObjectContext: coreDataStack.mainContext,
        coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
      super.tearDown()
      recipeService = nil
      coreDataStack = nil
    }
    
    func testAddRecipe() {
    // 1
    let recipe = recipeService.add(
    "Blueberry Pie",
    instructions: "Get Blueberries...Bake at 425...Eat",
    notes: "Use fresh blueberries!",
    createdAt: Date())

    // 2
    XCTAssertNotNil(recipe, "Recipe should not be nil")
    XCTAssertTrue(recipe.name == "Blueberry Pie")
    XCTAssertTrue(recipe.instructions == "Get Blueberries...Bake at 425...Eat")
    XCTAssertTrue(recipe.notes == "Use fresh blueberries!")

    }
    
    func testContextIsSavedAfterAddingRecipe() {
        
      let derivedContext = coreDataStack.newDerivedContext()
      recipeService = URecipesService(
        managedObjectContext: derivedContext,
        coreDataStack: coreDataStack)
        
      expectation(
        forNotification: .NSManagedObjectContextDidSave,
        object: coreDataStack.mainContext) { _ in
          return true
      }

      derivedContext.perform {
        let recipe = self.recipeService.add(
          "Cherry Pie",
          instructions: "Get Cherries...Pit them...Bake at 425...Eat",
          notes: "Use cherries from Door County Wisconsin!",
          createdAt: Date())

        XCTAssertNotNil(recipe)
      }

      waitForExpectations(timeout: 5.0) { error in
        XCTAssertNil(error, "Save did not occur")
      }
    }
    
    func testGetRecipes() {
      
      let newRecipe = recipeService.add(
        "Chicken Pot Pie",
        instructions: "Cook chicken, cook all veggies, add together, add broth, bake, eat",
        notes: "None",
        createdAt: Date())
        
      let getRecipes = recipeService.getRecipes()

      XCTAssertNotNil(getRecipes)

      XCTAssertTrue(getRecipes?.count == 1)

      XCTAssertTrue(newRecipe.id == getRecipes?.first?.id)
    }
    
    func testUpdateRecipe() {
        
        let newRecipe = recipeService.add(
            "Cherry Pie",
            instructions: "Get Cherries...Pit them...Bake at 425...Eat",
            notes: "Use cherries from Door County Wisconsin!",
            createdAt: Date())

        newRecipe.instructions = "Get apples, peel, season, bake, eat."
        newRecipe.notes = "Mix sweet and tart apples for best results"
        newRecipe.name = "Apple Pie"

      let updatedRecipe = recipeService.update(newRecipe)

      XCTAssertTrue(newRecipe.id == updatedRecipe.id)
      XCTAssertEqual(updatedRecipe.instructions, "Get apples, peel, season, bake, eat.")
      XCTAssertEqual(updatedRecipe.notes, "Mix sweet and tart apples for best results")
      XCTAssertTrue(updatedRecipe.name == "Apple Pie")
    }
    
    func testDeleteRecipe() {
    
        let newRecipe = recipeService.add(
          "Pumpkin Pie",
          instructions: "Mix pumpkin puree and spice...bake...let sit...eat",
          notes: "Swap ginger and cinammon measurements.",
          createdAt: Date())

        var fetchRecipes = recipeService.getRecipes()
        XCTAssertTrue(fetchRecipes?.count == 1)
        XCTAssertTrue(newRecipe.id == fetchRecipes?.first?.id)

        recipeService.delete(newRecipe)

        fetchRecipes = recipeService.getRecipes()

        XCTAssertTrue(fetchRecipes?.isEmpty ?? false)
      }
}
