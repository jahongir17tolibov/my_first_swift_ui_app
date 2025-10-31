//
//  FavouritesPage.swift
//  my_first_swift_app
//
//  Created by Developer on 11/08/25.
//
import SwiftUI

struct FavouritesPage: View {
    @State private var searchText: String = ""
    @StateObject private var vm = FavouritesViewModel()
    @State private var showingClearAlert = false

    var body: some View {
        let favourites = filteredCountries(vm.countries)
        NavigationStack {
            VStack {
                switch vm.state {
                case .initial:
                    ProgressView()
                case .loading:
                    ProgressView()
                case .success:
                    if favourites.isEmpty {
                        Text("No favourite countries found")
                            .foregroundColor(.secondary)
                    } else {
                        List(favourites, id: \.id) { country in
                            FavouritesItem(country: country, onToggleFavourite: {
                                vm.toggleFavourite(country)
                            })
                        }
                    }
                case let .error(error):
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                }
            }
        }.navigationTitle("Favourite Countries")
            .task {
                vm.loadCountries()
            }
            .refreshable {
                vm.loadCountries()
            }
            .searchable(text: $searchText, prompt: "Search Country")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingClearAlert = true
                    }) {
                        Image(systemName: "xmark.circle")
                    }
                }
            }.alert("Are you sure you want to clear favourites?", isPresented: $showingClearAlert) {
                Button("Yes", role: .destructive) {
                    vm.clearFavourites()
                }
                Button("No", role: .cancel) {}
            }
    }

    func filteredCountries(_ countries: [FavouriteModel]) -> [FavouriteModel] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
