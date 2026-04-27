// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension CountriesAPI {
  class GetCountrySingleQuery: GraphQLQuery {
    static let operationName: String = "GetCountrySingle"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query GetCountrySingle($countryCode: ID!) { country(code: $countryCode) { __typename capital phone phones currency currencies code continent { __typename name code } emoji languages { __typename name native } } }"#
      ))

    public var countryCode: ID

    public init(countryCode: ID) {
      self.countryCode = countryCode
    }

    public var __variables: Variables? { ["countryCode": countryCode] }

    struct Data: CountriesAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { CountriesAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("country", Country?.self, arguments: ["code": .variable("countryCode")]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        GetCountrySingleQuery.Data.self
      ] }

      var country: Country? { __data["country"] }

      /// Country
      ///
      /// Parent Type: `Country`
      struct Country: CountriesAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { CountriesAPI.Objects.Country }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("capital", String?.self),
          .field("phone", String.self),
          .field("phones", [String].self),
          .field("currency", String?.self),
          .field("currencies", [String].self),
          .field("code", CountriesAPI.ID.self),
          .field("continent", Continent.self),
          .field("emoji", String.self),
          .field("languages", [Language].self),
        ] }
        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          GetCountrySingleQuery.Data.Country.self
        ] }

        var capital: String? { __data["capital"] }
        var phone: String { __data["phone"] }
        var phones: [String] { __data["phones"] }
        var currency: String? { __data["currency"] }
        var currencies: [String] { __data["currencies"] }
        var code: CountriesAPI.ID { __data["code"] }
        var continent: Continent { __data["continent"] }
        var emoji: String { __data["emoji"] }
        var languages: [Language] { __data["languages"] }

        /// Country.Continent
        ///
        /// Parent Type: `Continent`
        struct Continent: CountriesAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { CountriesAPI.Objects.Continent }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("name", String.self),
            .field("code", CountriesAPI.ID.self),
          ] }
          static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
            GetCountrySingleQuery.Data.Country.Continent.self
          ] }

          var name: String { __data["name"] }
          var code: CountriesAPI.ID { __data["code"] }
        }

        /// Country.Language
        ///
        /// Parent Type: `Language`
        struct Language: CountriesAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { CountriesAPI.Objects.Language }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("name", String.self),
            .field("native", String.self),
          ] }
          static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
            GetCountrySingleQuery.Data.Country.Language.self
          ] }

          var name: String { __data["name"] }
          var native: String { __data["native"] }
        }
      }
    }
  }

}