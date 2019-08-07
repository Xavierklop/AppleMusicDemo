//
//  AlbumLookupResponse.swift
//  AppleMusic
//
//  Created by Hao Wu on 06.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

struct AlbumLookupResponse: Decodable {
    let resultCount: Int
    let results: [ArtistOrAlbum]
}

enum ArtistOrAlbum: Decodable {
    case artist(ItunesArtist)
    case album(ItunesAlbum)
}

extension ArtistOrAlbum {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .artist(container.decode(ItunesArtist.self))
        } catch {
            do {
                self = try .album(container.decode(ItunesAlbum.self))
            } catch {
                throw DecodingError.typeMismatch(ArtistOrAlbum.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload conflicts with expected type, (ItunesArtist or ArtistAlbum)") )
            }
        }
    }
}
