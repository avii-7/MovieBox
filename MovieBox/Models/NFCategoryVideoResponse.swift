//
//  NFCategoryVideoResponse.swift
//  MovieBox
//
//  Created by Arun on 12/05/24.
//

import Foundation


// MARK: - Welcome
struct NFCategoryVideoResponse: Decodable {
    let id: Int
    let results: [NFVideo]
}

// MARK: - Result
struct NFVideo: Decodable {
    let iso639_1: ISO639_1
    let iso3166_1: ISO3166_1
    let name, key: String
    let site: Site
    let size: Int
    let type: TypeEnum
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

enum ISO3166_1: String, Decodable {
    case us = "US"
}

enum ISO639_1: String, Decodable {
    case en = "en"
}

enum Site: String, Decodable {
    case youTube = "YouTube"
}

enum TypeEnum: String, Decodable {
    case clip = "Clip"
    case featurette = "Featurette"
    case teaser = "Teaser"
    case trailer = "Trailer"
    case behindTheScene = "Behind the Scenes"
}
