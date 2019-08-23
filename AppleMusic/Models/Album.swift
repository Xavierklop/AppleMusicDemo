//
//  Album.swift
//  AppleMusic
//
//  Created by Hao Wu on 22.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation
import UIKit

enum AlbumArtworkState {
    case placeholder
    case downloaded
    case failed
}

class Album {
    let id: Int
    let artistName: String
    let name: String
    let censoredName: String
    let artworkUrl: String
    let isExplicit: Bool
    let numberOfTracks: Int
    let releaseDate: Date
    let primaryGenre: String
    var songs = [Song]()
    var artwork: UIImage?
    var artworkState = AlbumArtworkState.placeholder
    var artworkData: Data?
    
    init(id: Int, artistName: String, name: String, censoredName: String,artworkUrl: String, isExplicit: Bool, numberOfTracks: Int, releaseDate: Date, primaryGenre: String) {
        self.id = id
        self.artistName = artistName
        self.name = name
        self.censoredName = censoredName
        self.artworkUrl = artworkUrl
        self.isExplicit = isExplicit
        self.numberOfTracks = numberOfTracks
        self.releaseDate = releaseDate
        self.primaryGenre = primaryGenre
    }
}
