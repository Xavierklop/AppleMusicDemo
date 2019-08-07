//
//  AlbumDetailViewModel.swift
//  AppleMusic
//
//  Created by Hao Wu on 26.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

struct AlbumDetailViewModel {
    let title: String
    let genre: String
    let releaseDate: String
}

extension AlbumDetailViewModel {
    init(album: Album) {
        self.title = album.censoredName
        self.genre = album.primaryGenre
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM dd, yyyy"
        
        self.releaseDate = formatter.string(from: album.releaseDate)
    }
}
