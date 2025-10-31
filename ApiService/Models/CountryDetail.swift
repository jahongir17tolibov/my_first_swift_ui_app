//
//  CountryDetail.swift
//  my_first_swift_app
//
//  Created by Developer on 06/08/25.
//

import Foundation

struct CountryDetail: Codable {
    let name: Name
    let tld: [String]?
    let cca2: String
    let ccn3: String?
    let cioc: String?
    let independent: Bool?
    let status: String?
    let unMember: Bool?
    let currencies: [String: Currency]?
    let idd: IDD?
    let capital: [String]?
    let altSpellings: [String]?
    let region: String?
    let subregion: String?
    let languages: [String: String]?
    let latlng: [Double]?
    let landlocked: Bool?
    let borders: [String]?
    let area: Double?
    let demonyms: Demonyms?
    let cca3: String
    let translations: [String: Translation]?
    let flag: String?
    let maps: Maps?
    let population: Int?
    let gini: [String: Double]?
    let fifa: String?
    let car: Car?
    let timezones: [String]?
    let continents: [String]?
    let flags: Flags?
    let coatOfArms: CoatOfArms?
    let startOfWeek: String?
    let capitalInfo: CapitalInfo?
    let postalCode: PostalCode?
}

struct Currency: Codable {
    let symbol: String?
    let name: String?
}

struct IDD: Codable {
    let root: String?
    let suffixes: [String]?
}

struct Demonyms: Codable {
    let eng: Gender?
    let fra: Gender?

    struct Gender: Codable {
        let f: String?
        let m: String?
    }
}

struct Translation: Codable {
    let official: String?
    let common: String?
}

struct Maps: Codable {
    let googleMaps: String?
    let openStreetMaps: String?
}

struct Car: Codable {
    let signs: [String]?
    let side: String?
}

struct CoatOfArms: Codable {
    let png: String?
    let svg: String?
}

struct CapitalInfo: Codable {
    let latlng: [Double]?
}

struct PostalCode: Codable {
    let format: String?
    let regex: String?
}

extension CountryDetail {
    func toFavouritesModel() -> FavouriteModel {
        return FavouriteModel(
            title: name.common,
            subtitle: name.official,
            imageName: flags?.png ?? "",
            isFavourite: true
        )
    }
}
