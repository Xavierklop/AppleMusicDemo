//
//  Artist.swift
//  AppleMusic
//
//  Created by Hao Wu on 22.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

class Artist {
    let id: Int
    let name: String
    let primaryGenre: String
    // MARK: - finally we don't need this
    var albums: [Album]

    init(id: Int, name: String, primaryGenre: String, albums: [Album]) {
        self.id = id
        self.name = name
        self.primaryGenre = primaryGenre
        self.albums = albums
    }
}
