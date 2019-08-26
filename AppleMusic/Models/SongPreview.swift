//
//  SongPreview.swift
//  AppleMusic
//
//  Created by Hao Wu on 26.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation.NSURL

class SongPreview {
    let previewURL: URL
    let index: Int
    var downloaded = false
    
    init(previewURL: URL, index: Int) {
        self.previewURL = previewURL
        self.index = index
    }
}
