//
//  ItunesSearchResponse.swift
//  AppleMusic
//
//  Created by Hao Wu on 05.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

struct ItunesSearchResponse: Decodable {
    let resultCount: Int
    let results: [ItunesArtistResponse]
}
