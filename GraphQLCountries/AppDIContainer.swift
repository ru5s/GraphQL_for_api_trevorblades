//
//  AppDIContainer.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 29/04/26.
//

import Foundation

final class AppDIContainer {
    //Repositories
    private lazy var countriesRepository: CountriesRepository = {
        CountriesRepositoryImpl()
    }()
    
    private lazy var continentRepository: ContinentRepository = {
        ContinentRepositoryImpl()
    }()
    
    //UseCases
    lazy var getCountriesUseCase: GetCountriesUseCase = {
        GetCountriesUseCase(repository: countriesRepository)
    }()
    
    lazy var getContinentUseCase: GetContinentUseCase = {
        GetContinentUseCase(repository: continentRepository)
    }()
}
