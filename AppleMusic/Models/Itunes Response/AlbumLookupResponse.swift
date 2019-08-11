//
//  AlbumLookupResponse.swift
//  AppleMusic
//
//  Created by Hao Wu on 10.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

struct AlbumLookupResponse: Codable {
    let resultCount: Int
    let results: [AlbumResultsResponse]
}

