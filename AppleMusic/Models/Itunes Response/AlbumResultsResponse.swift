//
//  AlbumResultsResponse.swift
//  AppleMusic
//
//  Created by Hao Wu on 10.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

struct AlbumResultsResponse: Codable {
    let artistID: Int
    let collectionID: Int
    let artistName: String
    let collectionName, collectionCensoredName: String
    let artworkUrl100: String
    let collectionExplicitness: String
    let trackCount: Int
    let releaseDate: String
    let primaryGenreName: String
    let trackID: Int?
    let trackName, trackCensoredName: String?
    let trackExplicitness: String?
    let trackTimeMillis: Int?
    let previewURL: String?
    
    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case collectionID = "collectionId"
        case artistName, collectionName, collectionCensoredName
        case artworkUrl100, collectionExplicitness, trackCount, releaseDate, primaryGenreName
        case trackID = "trackId"
        case trackName, trackCensoredName
        case trackExplicitness, trackTimeMillis
        case previewURL = "previewUrl"
    }
}
