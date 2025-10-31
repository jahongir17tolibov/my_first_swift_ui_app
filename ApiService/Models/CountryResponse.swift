//
//  CountryResponse.swift
//  my_first_swift_app
//
//  Created by Developer on 06/08/25.
//

import Foundation

struct CountryResponse: Codable {
    let flags: Flags
    let name: Name
}

extension CountryResponse {
    func toFavouriteModel() -> FavouriteModel {
        return FavouriteModel(
            title: name.common,
            subtitle: name.official,
            imageName: flags.png ?? "",
            isFavourite: true
        )
    }
}
