// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension CountriesAPI {
  class GetContinentsQuery: GraphQLQuery {
    static let operationName: String = "GetContinents"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query GetContinents { continents { __typename code name } }"#
      ))

    public init() {}

    struct Data: CountriesAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { CountriesAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("continents", [Continent].self),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        GetContinentsQuery.Data.self
      ] }

      var continents: [Continent] { __data["continents"] }

      /// Continent
      ///
      /// Parent Type: `Continent`
      struct Continent: CountriesAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { CountriesAPI.Objects.Continent }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("code", CountriesAPI.ID.self),
          .field("name", String.self),
        ] }
        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          GetContinentsQuery.Data.Continent.self
        ] }

        var code: CountriesAPI.ID { __data["code"] }
        var name: String { __data["name"] }
      }
    }
  }

}