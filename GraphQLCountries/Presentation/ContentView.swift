//
//  ContentView.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 23/04/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel = CountriesViewModel()
    
    var body: some View {
        NavigationStack {
                VStack {
                    Group {
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(maxHeight: .infinity)
                        } else if let error = viewModel.error {
                            Text(error)
                        } else {
                            List(viewModel.countries, id: \.id) { country in
                                HStack {
                                    Text(country.emoji)
                                    Text("\(country.name) \(viewModel.getNumberBySingleCountry(id: country.id))")
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button(action: {
                                        Task {
                                            await viewModel.fetchSingleCountryUseCase(id: country.id)
                                            viewModel.choosedCountry = country
                                        }
                                    }, label: {Label("Open", systemImage: "internaldrive.fill").tint(.teal)})
                                }
                            }
                            .listStyle(.sidebar)
                            
                        }
                    }
                }
                .navigationTitle("Countries")
                .navigationDestination(item: $viewModel.choosedCountry, destination: { country in
                    DetailCountryView(country: viewModel.choosedCountrySingle)
                })
                .safeAreaInset(edge: .bottom) {
                    safeAreaInsetView
                }
        }
        .task {
            await viewModel.fetchContinentsUseCase()
            await viewModel.fetchCountriesUseCase(nil)
        }
    }
    
    private var safeAreaInsetView: some View {
        ScrollView(.horizontal) {
            let choosed = viewModel.choosedContinent != nil
            
            LazyHStack {
                Button {
                    viewModel.choosedContinent = nil
                    Task {
                        await viewModel.fetchCountriesUseCase(nil)
                    }
                } label: {
                    Text("All")
                        .foregroundStyle(.black)
                        .padding(.horizontal)
                        .frame(height: 40)
                        .background(!choosed ? Color.teal : Color.yellow)
                        .clipShape(Capsule())
                }
                
                ForEach(viewModel.continents, id: \.id) { continent in
                    Button {
                        viewModel.choosedContinent = continent
                        Task {
                            await viewModel.fetchCountriesUseCase(continent.id)
                        }
                    } label: {
                        Text("\(continent.name)")
                            .foregroundStyle(.black)
                            .padding(.horizontal)
                            .frame(height: 40)
                            .background(choosed && viewModel.choosedContinent == continent ? Color.teal : Color.yellow)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 40)
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
