//
//  URecipesService.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 11/3/24.
//

import Foundation
import CoreData

public final class URecipesService {
  let managedObjectContext: NSManagedObjectContext
  let coreDataStack: CoreDataStack

  public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
    self.managedObjectContext = managedObjectContext
    self.coreDataStack = coreDataStack
  }
}

extension URecipesService {
  @discardableResult
  public func add(_ name: String, instructions: String, notes: String, createdAt: Date) -> UserRecipe {
    let recipe = UserRecipe(context: managedObjectContext)
      recipe.name = name
      recipe.instructions = instructions
      recipe.notes = notes
      recipe.createdAt = Date()
    coreDataStack.saveContext(managedObjectContext)
    return recipe
  }

  public func getRecipes() -> [UserRecipe]? {
    let recipeFetch: NSFetchRequest<UserRecipe> = UserRecipe.fetchRequest()
    do {
      let results = try managedObjectContext.fetch(recipeFetch)
      return results
    } catch let error as NSError {
      print("Fetch error: \(error) description: \(error.userInfo)")
    }
    return nil
  }

  @discardableResult
  public func update(_ recipe: UserRecipe) -> UserRecipe {
    coreDataStack.saveContext(managedObjectContext)
    return recipe
  }

  public func delete(_ recipe: UserRecipe) {
    managedObjectContext.delete(recipe)
    coreDataStack.saveContext(managedObjectContext)
  }
}
