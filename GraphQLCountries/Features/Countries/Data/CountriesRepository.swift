//
//  CountriesRepository.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 29/04/26.
//

import Foundation
import Apollo

protocol CountriesRepository {
    func fetchAll() -> AsyncStream<CountriesStateStream>
    func fetchByContinent(_ continent: String) -> AsyncStream<CountriesStateStream>
    func getCountryByID(code: String) async throws -> SingleCountryModel
}

final class CountriesRepositoryImpl: CountriesRepository {
    private var cacheSingleCountry: [String : SingleCountryModel] = [:]
    
    func fetchAll() -> AsyncStream<CountriesStateStream> {
        AsyncStream { continuation in
            continuation.yield(.loading)
            let concreteQuery = CountriesAPI.GetCountriesQuery()
            NetworkService.shared.apollo.fetch(query: concreteQuery, cachePolicy: .returnCacheDataAndFetch) { result in
                switch result {
                case .success(let graphQLResult):
                    let countries: [CountryModel] = graphQLResult.data?.countries.map {
                        CountryModel(id: $0.code, name: $0.name, emoji: $0.emoji)
                    } ?? []
                    continuation.yield(.data(countries))
                    continuation.finish()
                case .failure(let error):
                    continuation.yield(.error(error))
                    continuation.finish()
                }
            }
        }
    }
    
    func fetchByContinent(_ continent: String) -> AsyncStream<CountriesStateStream> {
        AsyncStream { continuation in
            continuation.yield(.loading)
            let concreteQuery = CountriesAPI.GetCountriesByContinentQuery(continent: continent)
            NetworkService.shared.apollo.fetch(query: concreteQuery, cachePolicy: .returnCacheDataAndFetch) { result in
                switch result {
                case .success(let graphQLResult):
                    let countries: [CountryModel] = graphQLResult.data?.countries.map {
                        CountryModel(id: $0.code, name: $0.name, emoji: $0.emoji)
                    } ?? []
                    continuation.yield(.data(countries))
                    continuation.finish()
                case .failure(let error):
                    continuation.yield(.error(error))
                    continuation.finish()
                }
            }
        }
    }
    
    func getCountryByID(code: String) async throws -> SingleCountryModel {
        try await withCheckedThrowingContinuation { continuation in
            NetworkService.shared.apollo.fetch(query: CountriesAPI.GetCountrySingleQuery(countryCode: code), cachePolicy: .returnCacheDataElseFetch) { result in
                switch result {
                case .success(let country):
                    let unwarpResult = country.data?.country.map {
                        SingleCountryModel(
                            id: $0.code,
                            capital: $0.capital,
                            phone: $0.phone,
                            phones: $0.phones,
                            currency: $0.currency,
                            currencies: $0.currencies,
                            continent: ContinentModel(id: $0.continent.code, name: $0.continent.name),
                            emoji: $0.emoji,
                            languages: $0.languages.map({LanguageModel(name: $0.name, native: $0.native)}))
                    } ?? SingleCountryModel()
                    continuation.resume(returning: unwarpResult)
                case .failure(let error):
                    print(error)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

final class MockCountriesRepositoryImpl: CountriesRepository {
    func fetchAll() -> AsyncStream<CountriesStateStream> {
        AsyncStream { continuation in
            let returnMock: [CountryModel] = [.init(id: "US", name: "United", emoji: "")]
            continuation.yield(.data(returnMock))
            continuation.finish()
        }
    }
    
    func fetchByContinent(_ continent: String) -> AsyncStream<CountriesStateStream> {
        AsyncStream { continuation in
            let returnMock: [CountryModel] = [.init(id: "BS", name: "United", emoji: ""), .init(id: "DS", name: "United", emoji: "")]
            continuation.yield(.data(returnMock))
            continuation.finish()
        }
    }
    
    func getCountryByID(code: String) async throws -> SingleCountryModel {
        return .init()
    }
    
    
}
