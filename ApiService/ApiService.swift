//
//  ApiService.swift
//  my_first_swift_app
//
//  Created by Developer on 06/08/25.
//
import Foundation

class ApiService {
    static let shared = ApiService()
    private init() {}

    let baseURL: String = "https://restcountries.com/v3.1/"

    func fetchCountries() async throws -> [CountryResponse] {
        guard let url = URL(string: "\(baseURL)all?fields=name,flags") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let countries = try JSONDecoder().decode([CountryResponse].self, from: data)
        return countries
    }

    func fetchCountryByName(_ name: String) async throws -> CountryDetail? {
        guard let url = URL(string: "\(baseURL)name/\(name)") else {
            throw URLError(.badURL)
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            print("✅ Got response data")

            print("🧾 Raw Response: \(String(data: data, encoding: .utf8) ?? "No response body")")
            let country = try JSONDecoder().decode([CountryDetail].self, from: data)
            return country.first
        } catch {
            print("❌ Error while fetching or decoding: \(error)")
            throw error
        }
    }
}
