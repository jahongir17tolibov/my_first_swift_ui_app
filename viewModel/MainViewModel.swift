//
//  MainViewModel.swift
//  my_first_swift_app
//
//  Created by Developer on 06/08/25.
//

import Foundation

@MainActor
class MainViewModel: ObservableObject {
    @Published var countries: [CountryResponse] = []
    @Published var country: CountryDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isFavourite = false

    func loadCountries() async {
        do {
            let data = try await ApiService.shared.fetchCountries()
            countries = data.sorted { $0.name.common < $1.name.common }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func getCountryByName(_ name: String) async {
        isLoading = true
        do {
            let data = try await ApiService.shared.fetchCountryByName(name)
            country = data
            isFavourite = LocalSources.shared.getFavourites().contains(where: { $0.title == data?.name.common })
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func toggleFavourite(_ country: CountryDetail) {
        if isFavourite {
            LocalSources.shared.removeFavourite(country.name.common)
        } else {
            LocalSources.shared.saveFavourite(country.toFavouritesModel())
        }
        isFavourite = !isFavourite
    }
}
