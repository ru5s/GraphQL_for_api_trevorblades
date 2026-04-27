//
//  NetworkService.swift
//  GraphQLCountries
//
//  Created by Ruslan Ismailov on 23/04/26.
//

import Foundation
import Apollo

final class NetworkService {
    
    static let shared = NetworkService()
    
    private let store = ApolloStore()
    
    private lazy var transport: RequestChainNetworkTransport = {
       RequestChainNetworkTransport(interceptorProvider: DefaultInterceptorProvider(store: store), endpointURL: URL(string: "https://countries.trevorblades.com/")!)
    }()
    
    private(set) lazy var apollo: ApolloClient = ApolloClient(networkTransport: transport, store: store)
}
