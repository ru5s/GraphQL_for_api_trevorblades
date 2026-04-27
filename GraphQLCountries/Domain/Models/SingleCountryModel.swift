//
//  SingleCountryModel.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 24/04/26.
//

import Foundation

struct LanguageModel: Identifiable {
    var id: UUID = .init()
    let name: String
    let native: String
}

struct SingleCountryModel: Identifiable {
    let id: String
    let capital: String?
    let phone: String
    let phones: [String]
    let currency: String?
    let currencies: [String]
    let continent: ContinentModel
    let emoji: String
    let languages: [LanguageModel]
}
