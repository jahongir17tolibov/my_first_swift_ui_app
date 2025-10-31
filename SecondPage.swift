//
//  secondPage.swift
//  my_first_swift_app
//
//  Created by Developer on 05/08/25.
//
import SwiftUI

struct SecondPage: View {
    let countryName: String
    @StateObject private var vm = MainViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                if vm.isLoading {
                    ProgressView()
                } else if let country = vm.country {
                    ScrollView {
                        VStack(alignment: .leading) {
                            VStack {
                                Spacer()
                                AsyncImage(url: URL(string: country.flags?.png ?? "")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 350, height: 180)
                                .cornerRadius(10)
                                .aspectRatio(contentMode: .fit)
                                Spacer()
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)

                            Text("Official Name: ")
                                .font(.title2).fontWeight(.bold) +
                                Text("\(country.name.official)")
                                .font(.title3)

                            Text("Capital: ").font(.title2).fontWeight(.bold) + Text("\(country.capital?.first ?? "")")
                                .font(.title3)

                            if let area = country.area {
                                Text("Area: ").font(.title2).fontWeight(.bold) + Text("\(area) km")
                                    .font(.title3)
                            } else {
                                Text("Area info not available")
                            }

                            Text("Flag: ").font(.title2).fontWeight(.bold) +
                                Text("\(country.flag ?? "N/A")")
                                .font(.headline)

                            Text("Population: ").font(.title2).fontWeight(.bold) + Text("\(country.population ?? 0)")
                                .font(.title3)

                            Text("Borders").font(.title).fontWeight(.bold)

                            if let borders = country.borders {
                                ForEach(borders, id: \.self) { border in
                                    Text(border)
                                }
                            }

                            if let continents = country.continents {
                                ForEach(continents, id: \.self) { continent in
                                    Text(continent)
                                }
                            } else {
                                Text("No continents available")
                            }
                        }.navigationTitle(country.name.common)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button {
                                        vm.toggleFavourite(country)
                                    } label: {
                                        Image(systemName: vm.isFavourite ? "heart.fill" : "heart")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                    }
                }
            }.alert("Error", isPresented: .constant(vm.errorMessage != nil)) {
                Button("OK") {
                    print("lewncowen")
                    vm.errorMessage = nil
                }
            }
            .task {
                await vm.getCountryByName(countryName)
            }.padding()
        }
    }

//    @State private var songsList: [String] = [
//        "Papercut",
//        "One Step Closer",
//        "With You",
//        "Points of Authority",
//        "Crawling",
//        "Runaway",
//        "By Myself",
//        "In the End",
//        "A Place for My Head",
//        "Forgotten",
//        "Cure for the Itch",
//        "Pushing Me Away",
//    ]
//
//    var body: some View {
//        VStack {
//            Grid(horizontalSpacing: 20, verticalSpacing: 20) {
//                GridRow {
//                    Image(systemName: "xmark")
//                    Image(systemName: "xmark")
//                    Image(systemName: "xmark")
//                }
//
//                GridRow {
//                    Image(systemName: "circle")
//                    Image(systemName: "xmark")
//                    Image(systemName: "circle")
//                }
//
//                GridRow {
//                    Image(systemName: "xmark")
//                    Image(systemName: "circle")
//                    Image(systemName: "circle")
//                }
//            }
//            .font(.largeTitle)
//
//            List {
//                ForEach(songsList, id: \.self) {
//                    song in
//                    Button(action: {}) {
//                        Text(song)
//                            .foregroundColor(Color.white)
//                            .frame(maxWidth: .infinity)
//                            .background(Color.red.gradient)
//                    }.background(.yellow)
//                        .cornerRadius(10)
//                }.onDelete(perform: removeSongs)
//            }
//            .navigationTitle("Hybrid Theory Songs")
//            .safeAreaInset(edge: .bottom) {
//                Button {
//                    print("Show help")
//                } label: {
//                    Image(systemName: "info.circle.fill")
//                        .font(.largeTitle)
//                        .symbolRenderingMode(.multicolor)
//                        .padding(.trailing)
//                }
//                .accessibilityLabel("Show help")
//            }
//        }
//    }
//
//    func removeSongs(at offsets: IndexSet) {
//        songsList.remove(atOffsets: offsets)
//    }
}

#Preview {
    SecondPage(countryName: "Uzbekistan")
}
