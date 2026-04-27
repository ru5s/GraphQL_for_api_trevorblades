// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension CountriesAPI {
  class GetEuropeanCountriesQuery: GraphQLQuery {
    static let operationName: String = "GetEuropeanCountries"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query GetEuropeanCountries { countries(filter: { continent: { eq: "EU" } }) { __typename name code } }"#
      ))

    public init() {}

    struct Data: CountriesAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { CountriesAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("countries", [Country].self, arguments: ["filter": ["continent": ["eq": "EU"]]]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        GetEuropeanCountriesQuery.Data.self
      ] }

      var countries: [Country] { __data["countries"] }

      /// Country
      ///
      /// Parent Type: `Country`
      struct Country: CountriesAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { CountriesAPI.Objects.Country }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", String.self),
          .field("code", CountriesAPI.ID.self),
        ] }
        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          GetEuropeanCountriesQuery.Data.Country.self
        ] }

        var name: String { __data["name"] }
        var code: CountriesAPI.ID { __data["code"] }
      }
    }
  }

}