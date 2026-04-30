//
//  AppDIContainer.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 29/04/26.
//

import Foundation
import SwiftUI

final class AppDIContainer {
    //Repositories
    private lazy var countriesRepository: CountriesRepository = {
        CountriesRepositoryImpl()
    }()
    
    private lazy var continentRepository: ContinentRepository = {
        ContinentRepositoryImpl()
    }()
    
    //UseCases transient
    func makeGetCountriesUseCase() -> GetCountriesUseCase {
        GetCountriesUseCase(repository: countriesRepository)
    }
    
    func makeGetContinentUseCase() -> GetContinentUseCase {
        GetContinentUseCase(repository: continentRepository)
    }
    
    deinit {
        print("deinit AppDIContainer")
    }
}

extension AppDIContainer {
    func makeCountriesView() -> some View {
        let vm = CountriesViewModel(
            getCountriesUseCase: makeGetCountriesUseCase(),
            getContinentUseCase: makeGetContinentUseCase()
        )
        return ContentView(viewModel: vm)
    }
}
