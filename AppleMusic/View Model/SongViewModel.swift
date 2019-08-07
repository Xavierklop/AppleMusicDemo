//
//  SongViewModel.swift
//  AppleMusic
//
//  Created by Hao Wu on 26.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

struct SongViewModel {
    let title: String
    let runTime: String
}

extension SongViewModel {
    init(song: Song) {
        self.title = song.censoredName
        
        let timeInSeconds = song.trackTime/1000
        // % 60
        let minutes = timeInSeconds/60
        let seconds = timeInSeconds%60
        
        self.runTime = "\(minutes): \(seconds)"
    }
}
