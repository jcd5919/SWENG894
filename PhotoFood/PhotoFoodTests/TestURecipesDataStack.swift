//
//  TestURecipesDataStack.swift
//  PhotoFoodTests
//
//  Created by Joseph Duckwall on 11/1/24.
//

import CoreData
import PhotoFood

class TestCoreDataStack: CoreDataStack {
  override init() {
    super.init()

    let persistentStoreDescription = NSPersistentStoreDescription()
    persistentStoreDescription.type = NSInMemoryStoreType

    let container = NSPersistentContainer(
      name: CoreDataStack.modelName,
      managedObjectModel: CoreDataStack.model)

    container.persistentStoreDescriptions = [persistentStoreDescription]

    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }

    storeContainer = container
  }
}
