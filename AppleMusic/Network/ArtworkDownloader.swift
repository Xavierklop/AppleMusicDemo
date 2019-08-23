//
//  ArtworkDownloader.swift
//  AppleMusic
//
//  Created by Hao Wu on 13.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation
import UIKit

class ArtworkDownloader: Operation {
    let album: Album
    
    init(album: Album) {
        self.album = album
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        guard let url = URL(string: album.artworkUrl) else {
            return
        }
        
        do {
            let imageData = try Data(contentsOf: url)
            if imageData.count > 0 {
                album.artwork = UIImage(data: imageData)
                album.artworkState = .downloaded
                album.artworkData = imageData
            } else {
                album.artworkState = .failed
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
