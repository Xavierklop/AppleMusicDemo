//
//  ItunesArtist.swift
//  AppleMusic
//
//  Created by Hao Wu on 05.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

struct ItunesArtistResponse: Decodable {
    let artistName: String
    let artistId: Int
    let primaryGenreId: Int
    let primaryGenreName: String
}
