//
//  FavouriteModel.swift
//  my_first_swift_app
//
//  Created by Developer on 12/08/25.
//

import Foundation

struct FavouriteModel: Codable, Identifiable {
    let id: UUID
    let title: String
    let subtitle: String
    let imageName: String
    var isFavourite: Bool

    init(id: UUID = UUID(), title: String, subtitle: String, imageName: String, isFavourite: Bool) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.isFavourite = isFavourite
    }

    func copy(
        id: UUID? = nil,
        title: String? = nil,
        subtitle: String? = nil,
        imageName: String? = nil,
        isFavourite: Bool? = nil
    ) -> FavouriteModel {
        return FavouriteModel(
            id: id ?? self.id,
            title: title ?? self.title,
            subtitle: subtitle ?? self.subtitle,
            imageName: imageName ?? self.imageName,
            isFavourite: isFavourite ?? self.isFavourite
        )
    }
}
