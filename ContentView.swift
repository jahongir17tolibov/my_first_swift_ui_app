//
//  ContentView.swift
//  my_first_swift_app
//
//  Created by Developer on 31/07/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = MainViewModel()
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            List(filteredCountries(vm.countries), id: \.name.common) { country in
                NavigationLink(destination: SecondPage(countryName: country.name.common)) {
                    HStack {
                        AsyncImage(url: URL(string: country.flags.png ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 40)
                        .cornerRadius(4)
                        VStack(alignment: .leading) {
                            Text(country.name.common)
                                .font(.headline)
                            Text(country.name.official)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .refreshable {
                await vm.loadCountries()
            }
            .navigationTitle("Countries")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: FavouritesPage()) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.black)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search Country")
            .task {
                await vm.loadCountries()
            }
            .alert("Error", isPresented: .constant(vm.errorMessage != nil)) {
                Button("OK") { vm.errorMessage = nil }
            } message: {
                Text(vm.errorMessage ?? "")
            }
        }
    }

    func filteredCountries(_ countries: [CountryResponse]) -> [CountryResponse] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter { $0.name.common.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

// struct ContentView: View {
//    @StateObject private var vm = MainViewModel()
//
//    var body: some View {
//        NavigationStack {
//            List(vm.countries, id: \.name.common) { country in
//                HStack {
//                    AsyncImage(url: URL(string: country.flags.png)) { image in
//                        image.resizable()
//                    } placeholder: {
//                        ProgressView()
//                    }
//                    .frame(width: 60, height: 40)
//                    .cornerRadius(4)
//
//                    VStack(alignment: .leading) {
//                        Text(country.name.common)
//                            .font(.headline)
//                        Text(country.name.official)
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                    }
//                }
//            }
//            .navigationTitle("Countries")
//            .task {
//                await vm.loadCountries()
//            }
//            .alert(item: $vm.errorMessage) { msg in
//                Alert(title: Text("Error"), message: Text(msg), dismissButton: .default(Text("OK")))
//            }
//        }
//    }
//
////    @State private var tapIndex: Int = 0
////    @State private var isOn: Bool = false
////    @Environment(\.horizontalSizeClass) var horizontalSizeClass
////
////    var body: some View {
////        ScrollView {
////            VStack(alignment: .leading) {
////                NavigationLink(destination: SecondPage()) {
////                    Image(systemName: "globe")
////                        .imageScale(.large)
////                }
////                Divider()
////                Text("Hello, world! pushing me the ongoiung deeper ntoin")
////                    .frame(width: 200)
////                    .lineLimit(2)
////                    .font(.headline)
////                    .foregroundStyle(.linearGradient(
////                        colors: [.red, .black],
////                        startPoint: .top,
////                        endPoint: .bottom
////                    ))
////                    .background(Color.mint, alignment: Alignment.leading)
////
////                AsyncImage(url: URL(string: slowRushImgUrl)) { phase in
////                    switch phase {
////                    case .empty:
////                        ProgressView()
////                    case let .success(image):
////                        image
////                            .resizable()
////                            .scaledToFit()
////                            .cornerRadius(20)
////                            .overlay {
////                                RoundedRectangle(cornerRadius: 20)
////                                    .stroke(Color.mint, lineWidth: 8)
////                            }
////                    case .failure:
////                        Image(systemName: "photo") // xato bo‘lsa default icon
////                    @unknown default:
////                        EmptyView()
////                    }
////                }
////                .frame(width: 120, height: 120)
////
////                Spacer().frame(height: 20)
////                ZStack {
////                    Rectangle()
////                        .fill(.green)
////                        .frame(width: 50, height: 50)
////                        .zIndex(1)
////
////                    Rectangle()
////                        .fill(.red)
////                        .frame(width: 100, height: 100)
////                }
////
////                ZStack {
////                    RoundedRectangle(cornerRadius: 8)
////                        .fill(Color.green)
////                        .frame(width: 200, height: 80)
////
////                    Text("runaway \(tapIndex)")
////                }
////                Toggle("Switch", isOn: $isOn)
////                    .padding()
////            }
////            .padding()
////        }
////    }
// }

#Preview {
//    ContentView()
}

let slowRushImgUrl = "data:image/jpeg;base64,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"
