//
//  CountryModel.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 23/04/26.
//

import Foundation

struct CountryModel: Identifiable, Hashable {
    let id: String
    let name: String
    let emoji: String
}
