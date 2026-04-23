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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
