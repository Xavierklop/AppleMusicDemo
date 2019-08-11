//
//  ArtistResultsResponse.swift
//  AppleMusic
//
//  Created by Hao Wu on 09.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

struct ArtistResultsResponse: Codable {
    let artistName: String
    let artistID: Int
    let primaryGenreName: String
    let collectionType: String?
    let collectionID: Int?
    let collectionName, collectionCensoredName: String?
    let artworkUrl100: String?
    let collectionExplicitness: String?
    let releaseDate: String?
    let trackCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case collectionID = "collectionId"
        case collectionName, collectionCensoredName, artworkUrl100, collectionExplicitness, releaseDate,artistName, primaryGenreName, collectionType, trackCount
    }
}
