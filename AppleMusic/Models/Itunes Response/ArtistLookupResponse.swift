//
//  ArtistLookupResponse.swift
//  AppleMusic
//
//  Created by Hao Wu on 06.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

struct ArtistLookupResponse: Codable {
    let resultCount: Int
    let results: [ArtistResultsResponse]
}

