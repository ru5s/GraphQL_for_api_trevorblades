//
//  ContentView.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 23/04/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel: CountriesViewModel
    
    init(viewModel: CountriesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
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
                                .onTapGesture {
                                    viewModel.fetchSingleCountryUseCase(country: country)
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button(action: {
                                        viewModel.fetchSingleCountryUseCase(country: country, onlyPhone: true)
                                    }, label: {Label("Get phone", systemImage: "phone.circle.fill").tint(.teal)})
                                }
                            }
                            .listStyle(.sidebar)
                            .safeAreaInset(edge: .bottom) {
                                safeAreaInsetView
                            }
                            
                        }
                    }
                }
                .navigationDestination(item: $viewModel.choosedCountry, destination: { country in
                    DetailCountryView(country: viewModel.choosedCountrySingle)
                })
                .navigationTitle("Countries")
//                .sheet(item: $viewModel.choosedCountry, content: { country in
//                    DetailCountryView(country: viewModel.choosedCountrySingle)
//                })
        }
        .task {
            await viewModel.fetchContinentsUseCase()
            await viewModel.fetchCountriesUseCase(nil)
        }
    }
    
    @ViewBuilder private var safeAreaInsetView: some View {
            let choosed = viewModel.choosedContinent != nil
            ScrollView(.horizontal) {
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
    ContentView(viewModel: .init(getCountriesUseCase: GetCountriesUseCase(repository: CountriesRepositoryImpl()), getContinentUseCase: GetContinentUseCase(repository: ContinentRepositoryImpl()))).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
