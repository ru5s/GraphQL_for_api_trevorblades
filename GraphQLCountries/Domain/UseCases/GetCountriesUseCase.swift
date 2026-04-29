//
//  GetCountriesUseCase.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 29/04/26.
//

import Foundation

final class GetCountriesUseCase {
    private let repository: CountriesRepository
    
    init(repository: CountriesRepository) {
        self.repository = repository
    }
    
    func execute(continent: String?) -> AsyncStream<CountriesStateStream> {
        if let continent {
            return repository.fetchByContinent(continent)
        } else {
            return repository.fetchAll()
        }
    }
    
    func singleCountryByID(_ id: String) async throws -> SingleCountryModel {
        return try await repository.getCountryByID(code: id)
    }
}
