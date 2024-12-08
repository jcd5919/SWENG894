//
//  UserRecipe+CoreDataProperties.swift
//  PhotoFood
//
//  Created by Joseph Duckwall on 10/27/24.
//
//

import Foundation
import CoreData


extension UserRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserRecipe> {
        return NSFetchRequest<UserRecipe>(entityName: "UserRecipe")
    }

    @NSManaged public var name: String?
    @NSManaged public var instructions: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var notes: String?

}

extension UserRecipe : Identifiable {

}
