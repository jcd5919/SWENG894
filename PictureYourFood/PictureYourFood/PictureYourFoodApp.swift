//
//  PictureYourFoodApp.swift
//  PictureYourFood
//
//  Created by Joseph Duckwall on 9/16/24.
//

import SwiftUI

@main
struct PictureYourFoodApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
