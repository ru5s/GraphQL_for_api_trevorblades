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
    @Published var error: String?

    private var cacheSingleCountry: [String : SingleCountryModel] = [:]
    
    private let contriesUseCases: GetCountriesUseCase
    private let continentUseCases: GetContinentUseCase
    
    init() {
        let countriesRepo = CountriesRepositoryImpl()
        self.contriesUseCases = GetCountriesUseCase(repository: countriesRepo)
        
        let continentRepo = ContinentRepositoryImpl()
        self.continentUseCases = GetContinentUseCase(repository: continentRepo)
    }
    
    deinit {
        print("viewModel deinit")
    }
    
    func fetchCountriesUseCase(_ continent: String?) async {
        for await state in contriesUseCases.execute(continent: continent) {
            switch state {
            case .loading:
                isLoading = true
            case .data(let array):
                self.countries = array
                isLoading = false
            case .error(let error):
                print(error)
                isLoading = false
            }
        }
    }
    
    func fetchSingleCountryUseCase(id: String) async  {
        do {
            choosedCountrySingle = try await contriesUseCases.singleCountryByID(id)
            cacheSingleCountry[id] = choosedCountrySingle
        } catch {
            print(error)
        }
    }
    
    func fetchContinentsUseCase() async {
        do {
            continents = try await continentUseCases.execute()
        } catch {
            print(error)
        }
    }
    
    func getNumberBySingleCountry(id: String) -> String {
        if let findId = cacheSingleCountry.first(where: {$0.key == id}) {
            return "+" + findId.value.phone
        } else {
            return ""
        }
    }
}
