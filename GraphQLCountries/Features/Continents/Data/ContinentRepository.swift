//
//  ContinentRepository.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 29/04/26.
//

import Foundation
import Apollo

protocol ContinentRepository {
    func getAllContinents() async throws -> [ContinentModel]
}

final class ContinentRepositoryImpl: ContinentRepository {
    func getAllContinents() async throws -> [ContinentModel] {
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
}

final class MockContinentRepositoryImpl: ContinentRepository {
    func getAllContinents() async throws -> [ContinentModel] {
        return [.init(id: "1", name: ""), .init(id: "2", name: "")]
    }
}
