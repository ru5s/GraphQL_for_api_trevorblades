//
//  CountriesStateStream.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 28/04/26.
//

import Foundation

enum CountriesStateStream {
    case loading
    case data([CountryModel])
    case error(Error)
}
