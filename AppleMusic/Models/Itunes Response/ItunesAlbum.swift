//
//  ItunesAlbum.swift
//  AppleMusic
//
//  Created by Hao Wu on 06.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

struct ItunesAlbum: Decodable {
    let id: Int
    let artistName: String
    let name: String
    let censoredName: String
    let artworkUrl: String
    let isExplicit: Bool
    let numberOfTracks: Int
    let releaseDate: Date
    let primaryGenre: String
    
    enum CodingKeys: String, CodingKey {
        case id = "collectionId"
        case artistName
        case name = "collectionName"
        case censoredName = "collectionCensoredName"
        case artworkUrl = "artworkUrl100"
        case isExplicit = "collectionExplicitness"
        case numberOfTracks = "trackCount"
        case releaseDate
        case primaryGenre = "primaryGenreName"
    }
}
