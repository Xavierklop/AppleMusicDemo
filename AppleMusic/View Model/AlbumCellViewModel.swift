//
//  AlbumCellViewModel.swift
//  AppleMusic
//
//  Created by Hao Wu on 25.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation
import UIKit

struct AlbumCellViewModel {
    let title: String
    let genre: String
    let releaseDate: String
    let artwork: UIImage
}

extension AlbumCellViewModel {
    init(album: Album) {
        self.title = album.censoredName
        self.genre = album.primaryGenre
        self.artwork = album.artworkState == .downloaded ? album.artwork! : #imageLiteral(resourceName: "AlbumPlaceholder-1024")
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM dd, yyyy"
        
        self.releaseDate = formatter.string(from: album.releaseDate)
    }
}
