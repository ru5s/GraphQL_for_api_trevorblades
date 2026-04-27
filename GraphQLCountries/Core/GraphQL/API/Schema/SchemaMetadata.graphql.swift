// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

protocol CountriesAPI_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == CountriesAPI.SchemaMetadata {}

protocol CountriesAPI_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == CountriesAPI.SchemaMetadata {}

protocol CountriesAPI_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == CountriesAPI.SchemaMetadata {}

protocol CountriesAPI_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == CountriesAPI.SchemaMetadata {}

extension CountriesAPI {
  typealias SelectionSet = CountriesAPI_SelectionSet

  typealias InlineFragment = CountriesAPI_InlineFragment

  typealias MutableSelectionSet = CountriesAPI_MutableSelectionSet

  typealias MutableInlineFragment = CountriesAPI_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    private static let objectTypeMap: [String: ApolloAPI.Object] = [
      "Continent": CountriesAPI.Objects.Continent,
      "Country": CountriesAPI.Objects.Country,
      "Language": CountriesAPI.Objects.Language,
      "Query": CountriesAPI.Objects.Query
    ]

    static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
      objectTypeMap[typename]
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}