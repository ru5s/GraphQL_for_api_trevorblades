// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension CountriesAPI {
  class GetCountriesByContinentQuery: GraphQLQuery {
    static let operationName: String = "GetCountriesByContinent"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query GetCountriesByContinent($continent: String!) { countries(filter: { continent: { eq: $continent } }) { __typename code name emoji } }"#
      ))

    public var continent: String

    public init(continent: String) {
      self.continent = continent
    }

    public var __variables: Variables? { ["continent": continent] }

    struct Data: CountriesAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { CountriesAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("countries", [Country].self, arguments: ["filter": ["continent": ["eq": .variable("continent")]]]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        GetCountriesByContinentQuery.Data.self
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
          .field("code", CountriesAPI.ID.self),
          .field("name", String.self),
          .field("emoji", String.self),
        ] }
        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          GetCountriesByContinentQuery.Data.Country.self
        ] }

        var code: CountriesAPI.ID { __data["code"] }
        var name: String { __data["name"] }
        var emoji: String { __data["emoji"] }
      }
    }
  }

}