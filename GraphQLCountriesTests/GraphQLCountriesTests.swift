//
//  GraphQLCountriesTests.swift
//  GraphQLCountriesTests
//
//  Created by Ruslan Ismailov on 29/04/26.
//

import Testing
@testable import GraphQLCountries

struct GraphQLCountriesTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        
    }

    @Test
    @MainActor
    func testFetchAllCountries() async throws {
        let repo = MockCountriesRepositoryImpl()
        let useCase = GetCountriesUseCase(repository: repo)
        
        for await state in useCase.execute(continent: nil) {
            switch state {
            case .loading:
                print("loading")
            case .data(let array):
                #expect(array.count == 1)
            case .error(let error):
                print(error)
            }
        }
    }
    
    @Test
    @MainActor
    func testFetchByContinent() async throws {
        let repo = MockCountriesRepositoryImpl()
        let useCase = GetCountriesUseCase(repository: repo)
        
        for await state in useCase.execute(continent: "BS") {
            switch state {
            case .loading:
                print("loading")
            case .data(let array):
                #expect(array.count == 2)
            case .error(let error):
                print(error)
            }
        }
    }
    
    @Test
    @MainActor
    func testFetchSingleByID() async throws {
        let repo = MockCountriesRepositoryImpl()
        let useCase = GetCountriesUseCase(repository: repo)
        
        let result = try await useCase.singleCountryByID("BS")
        #expect(result.id == "BS")
    }
    
    @Test
    @MainActor
    func testFetchContinents() async throws {
        let repo = MockContinentRepositoryImpl()
        let useCase = GetContinentUseCase(repository: repo)
        let result = try await useCase.execute()
        #expect(result.count > 1)
    }
}

