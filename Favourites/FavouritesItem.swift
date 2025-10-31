//
//  FavouritesItem.swift
//  my_first_swift_app
//
//  Created by Developer on 12/08/25.
//

import SwiftUI

struct FavouritesItem: View {
    let country: FavouriteModel
    var onToggleFavourite: () -> Void

    var body: some View {
        HStack {
//            NavigationLink(destination: SecondPage(countryName: country.title)) {
            HStack {
                AsyncImage(url: URL(string: country.imageName)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 60, height: 40)
                .cornerRadius(4)
                VStack(alignment: .leading) {
                    Text(country.title)
                        .font(.headline)
                    Text(country.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
//            }

            Spacer()

            Button(action: onToggleFavourite) {
                Image(systemName: country.isFavourite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }.buttonStyle(PlainButtonStyle())
                .contentShape(Rectangle())

        }.padding(.vertical, 8)
    }
}
