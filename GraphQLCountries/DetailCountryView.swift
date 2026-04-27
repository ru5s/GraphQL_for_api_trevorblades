//
//  DetailCountryView.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 24/04/26.
//

import SwiftUI

struct DetailCountryView: View {
    @ObservedObject var viewModel: CountriesViewModel
    var body: some View {
        VStack {
            
            Text("Phone by country: + \(viewModel.choosedCountrySingle?.phone ?? "no phone")")
            
        }
        .navigationTitle(viewModel.choosedCountry?.name ?? "no name")
        .toolbarTitleDisplayMode(.inline)
        .task {
            if let code = viewModel.choosedCountry?.id {
                print("get by code \(code)")
                await viewModel.fetchCountry(code: code)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailCountryView(viewModel: CountriesViewModel())
    }
}
