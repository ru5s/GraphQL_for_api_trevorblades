//
//  GraphQLCountriesApp.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 23/04/26.
//

import SwiftUI
import CoreData

@main
struct GraphQLCountriesApp: App {
    let persistenceController = PersistenceController.shared
    let containger = AppDIContainer()

    var body: some Scene {
        WindowGroup {
            containger.makeCountriesView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
