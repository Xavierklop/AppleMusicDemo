//
//  AlbumLookupResponse.swift
//  AppleMusic
//
//  Created by Hao Wu on 06.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

struct AlbumLookupResponse: Codable {
    let resultCount: Int
    let results: [AlbumResultResponse]
}

struct AlbumResultResponse: Codable {
    let artistName: String
    let artistID: Int
    let primaryGenreName: String
    let primaryGenreID: Int?
    let collectionType: String?
    let collectionID: Int?
    let collectionName, collectionCensoredName: String?
    let artworkUrl100: String?
    let collectionExplicitness: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case primaryGenreID = "primaryGenreId"
        case collectionID = "collectionId"
        case collectionName, collectionCensoredName, artworkUrl100, collectionExplicitness, releaseDate,artistName, primaryGenreName, collectionType
        
    }
}
