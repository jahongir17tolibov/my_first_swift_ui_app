//
//  FavouritesViewModel.swift
//  my_first_swift_app
//
//  Created by Developer on 11/08/25.
//

import Foundation

class FavouritesViewModel: ObservableObject {
    @Published var countries: [FavouriteModel] = []
    @Published var state: FavouritesState = .initial

    func loadCountries() {
        print("ahhahaha")
        state = FavouritesState.loading
        let saved = LocalSources.shared.getFavourites()
        countries = saved
        state = FavouritesState.success
    }

    func toggleFavourite(_ country: FavouriteModel) {
        print(country.isFavourite)
        if !countries.isEmpty {
            if country.isFavourite {
                LocalSources.shared.removeFavourite(country.title)
            } else {
                LocalSources.shared.saveFavourite(country)
            }

            countries = countries.map { item in
                if item.id == country.id {
                    return item.copy(isFavourite: !item.isFavourite)
                } else {
                    return item
                }
            }
        }
    }

    func clearFavourites() {
        LocalSources.shared.clearFavourites()
        loadCountries()
    }
}

enum FavouritesState {
    case initial
    case loading
    case success
    case error(String)
}
