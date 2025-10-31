//
//  FlagsModel.swift
//  my_first_swift_app
//
//  Created by Developer on 06/08/25.
//

import Foundation

// MARK: - Flags

struct Flags: Codable {
    let png: String?
    let svg: String?
    let alt: String?
}

// MARK: - Name

struct Name: Codable {
    let common, official: String
    let nativeName: [String: NativeName]
}

// MARK: - NativeName

struct NativeName: Codable {
    let official, common: String
}
