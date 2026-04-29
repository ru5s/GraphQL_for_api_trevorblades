//
//  DetailCountryView.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 24/04/26.
//

import SwiftUI

struct DetailCountryView: View {
    @State var country: SingleCountryModel?
    var body: some View {
        VStack {
            
            Text("Phone by country: + \(country?.phone ?? "")")
            
        }
        .navigationTitle(country?.id ?? "no name")
        .toolbarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DetailCountryView(country: SingleCountryModel())
    }
}
