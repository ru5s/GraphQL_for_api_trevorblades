//
//  CountriesViewModel.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 23/04/26.
//

import Foundation
import Apollo
import Combine

@MainActor
final class CountriesViewModel: ObservableObject {
    
    @Published var countries: [CountryModel] = []
    @Published var choosedCountry: CountryModel? = nil
    @Published var continents: [ContinentModel] = []
    @Published var choosedContinent: ContinentModel? = nil
    @Published var choosedCountrySingle: SingleCountryModel? = nil
    @Published var isLoading = false
    @Published var isLoadingContinents = false
    @Published var error: String?

    private var cacheCountries: [String: [CountryModel]] = [:]
    private var cacheContinents: [ContinentModel] = []
    private var cacheSingleCountry: [String : SingleCountryModel] = [:]
    
    //Old method
//    func fetchCountries() {
//        isLoading = true
//        
//        NetworkService.shared.apollo.fetch(query: CountriesAPI.GetCountriesQuery()) { [weak self] result in
//            DispatchQueue.main.async {
//                self?.isLoading = false
//                
//                switch result {
//                case .success(let graphQLResult):
//                    self?.countries = graphQLResult.data?.countries.map({
//                        CountryModel(id: $0.code, name: $0.name, emoji: $0.emoji)
//                    }) ?? []
//                case .failure(let error):
//                    self?.error = error.localizedDescription
//                }
//            }
//        }
//    }
    
    deinit {
        print("viewModel deinit")
    }
    
    //Async await
//    private func fetchCountriesAsync() async throws -> [CountryModel] {
//        try await withCheckedThrowingContinuation { continuation in
//            NetworkService.shared.apollo.fetch(query: CountriesAPI.GetCountriesQuery(), cachePolicy: .returnCacheDataElseFetch) { result in
//                switch result {
//                case .success(let graphQlResult):
//                    let resultToSend: [CountryModel] = graphQlResult.data?.countries.map({
//                        CountryModel(id: $0.code, name: $0.name, emoji: $0.emoji)
//                    }) ?? []
//                    continuation.resume(returning: resultToSend)
//                case .failure(let error):
//                    continuation.resume(throwing: error)
//                }
//            }
//        }
//    }
//    
//    private func fetchFiltered(continent: String) async throws -> [CountryModel] {
//        try await withCheckedThrowingContinuation { continuation in
//            NetworkService.shared.apollo.fetch(query: CountriesAPI.GetCountriesByContinentQuery(continent: continent), cachePolicy: .returnCacheDataElseFetch) { result in
//                switch result {
//                case .success(let graphQlResult):
//                    let resultToSend: [CountryModel] = graphQlResult.data?.countries.map({
//                        CountryModel(id: $0.code, name: $0.name, emoji: $0.emoji)
//                    }) ?? []
//                    continuation.resume(returning: resultToSend)
//                case .failure(let error):
//                    continuation.resume(throwing: error)
//                }
//            }
//        }
//    }
//    
//    func fetchCountries(continent: String? = nil) async {
//        let key = continent ?? "All"
//        
//        if let cache = cacheCountries[key] {
//            countries = cache
//            print("cached countries \(countries.count)")
//            return
//        }
//        
//        isLoading = true
//        
//        defer {
//            isLoading = false
//            print("defer fetchCountries")
//        }
//        
//        do {
//            let result: [CountryModel]
//            
//            if let continent {
//                result = try await fetchFiltered(continent: continent)
//                print("filtered countries \(result.count)")
//            } else {
//                result = try await fetchCountriesAsync()
//                print("all countries \(result.count)")
//            }
//            
//            cacheCountries[key] = result
//            countries = result
//        } catch {
//            print("Error-" + error.localizedDescription)
//        }
//    }
    
    private func getAllContinents() async throws -> [ContinentModel] {
        try await withCheckedThrowingContinuation { continuation in
            NetworkService.shared.apollo.fetch(query: CountriesAPI.GetContinentsQuery(), cachePolicy: .returnCacheDataElseFetch) { result in
                switch result {
                case .success(let graphQlResult):
                    let resultToSend: [ContinentModel] = graphQlResult.data?.continents.map({
                        ContinentModel(id: $0.code, name: $0.name)
                    }) ?? []
                    continuation.resume(returning: resultToSend)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func fetchContinents() async {
        if !cacheContinents.isEmpty {
            continents = cacheContinents
            print("cache contintents \(continents.count)")
            return
        }
        
        do {
            continents = try await getAllContinents()
            cacheContinents = continents
        } catch {
            print("Error-" + error.localizedDescription)
        }
    }
    
    private func getCountryByID(code: String) async throws -> SingleCountryModel {
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
                    } ?? SingleCountryModel(id: "", capital: "", phone: "", phones: [], currency: "", currencies: [], continent: .init(id: "", name: ""), emoji: "", languages: [])
                    continuation.resume(returning: unwarpResult)
                case .failure(let error):
                    print(error)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func fetchCountry(code: String) async {
        let key: String = code
        
        if let cache = cacheSingleCountry[key] {
            choosedCountrySingle = cache
            print("cache country single")
            return
        }
        
        do {
            choosedCountrySingle = try await getCountryByID(code: key)
            cacheSingleCountry[key] = choosedCountrySingle
        } catch {
            print(error)
        }
    }
    
    //Async Stream
    private func fetchCountryStream(continent: String?) -> AsyncStream<CountriesStateStream> {
        AsyncStream { continuation in
            continuation.yield(.loading)
            
            if let continent, !continent.isEmpty {
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
            } else {
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
    }
    
    func fetchCountriesStream(continent: String?) async {
        for await state in fetchCountryStream(continent: continent) {
            switch state {
            case .loading:
                isLoading = true
                
            case .data(let countriesArray):
                self.countries = countriesArray
                isLoading = false
                
            case .error(let error):
                print(error)
                isLoading = false
            }
        }
    }
}
