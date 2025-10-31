//
//  LocalSources.swift
//  my_first_swift_app
//
//  Created by Developer on 11/08/25.
//
import Foundation

let favouritesKey = "savedFavourites"

final class LocalSources {
    static let shared = LocalSources()

    private init() {}

    func saveFavourite(_ item: FavouriteModel) {
        var list = getFavourites()

        if !list.contains(where: { $0.title == item.title }) {
            list.append(item)
            saveList(list)
        }
    }

    func removeFavourite(_ name: String) {
        var list = getFavourites()
        list.removeAll { $0.title == name }
        saveList(list)
    }

    func getFavourites() -> [FavouriteModel] {
        guard let data = UserDefaults.standard.data(forKey: favouritesKey) else {
            return []
        }
        return (try? JSONDecoder().decode([FavouriteModel].self, from: data)) ?? []
    }

    func clearFavourites() {
        UserDefaults.standard.removeObject(forKey: favouritesKey)
    }

    private func saveList(_ list: [FavouriteModel]) {
        if let data = try? JSONEncoder().encode(list) {
            UserDefaults.standard.set(data, forKey: favouritesKey)
        }
    }
}

extension UserDefaults {
    func setEncodable<T: Encodable>(_ value: T, forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            set(encoded, forKey: key)
        }
    }

    func decodableValue<T: Decodable>(forKey key: String, as type: T.Type) -> T? {
        guard let data = data(forKey: key) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(type, from: data)
    }
}
