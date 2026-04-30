//
//  GetContinentUseCase.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 29/04/26.
//

import Foundation

final class GetContinentUseCase {
    private let repository: ContinentRepository
    private var cacheContinents: [ContinentModel] = []
    
    init(repository: ContinentRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [ContinentModel] {
        let continents: [ContinentModel]
        if !cacheContinents.isEmpty {
            continents = cacheContinents
            print("cache contintents \(continents.count)")
            return continents
        }
        
        do {
            continents = try await repository.getAllContinents()
            cacheContinents = continents
            return continents
        } catch {
            print("Error-" + error.localizedDescription)
        }
        return []
    }
}
