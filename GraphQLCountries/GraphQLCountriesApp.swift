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
            ContentView(viewModel: CountriesViewModel(getCountriesUseCase: containger.getCountriesUseCase, getContinentUseCase: containger.getContinentUseCase))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
