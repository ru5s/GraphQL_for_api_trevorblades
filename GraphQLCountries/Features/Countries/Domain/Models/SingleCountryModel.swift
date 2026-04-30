//
//  SingleCountryModel.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 24/04/26.
//

import Foundation

struct LanguageModel: Identifiable, Hashable {
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
    
    init(id: String, capital: String?, phone: String, phones: [String], currency: String?, currencies: [String], continent: ContinentModel, emoji: String, languages: [LanguageModel]) {
        self.id = id
        self.capital = capital
        self.phone = phone
        self.phones = phones
        self.currency = currency
        self.currencies = currencies
        self.continent = continent
        self.emoji = emoji
        self.languages = languages
    }
    
    init() {
        self.id = "BS"
        self.capital = ""
        self.phone = "123"
        self.phones = []
        self.currency = nil
        self.currencies = []
        self.continent = .init(id: "", name: "")
        self.emoji = ""
        self.languages = []
    }
}
