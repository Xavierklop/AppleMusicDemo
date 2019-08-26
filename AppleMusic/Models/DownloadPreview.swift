//
//  DownloadedSong.swift
//  AppleMusic
//
//  Created by Hao Wu on 26.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

class DownloadPreview {
    var isDownloading = false
    var progress: Float = 0
    var resumeData: Data?
    var task: URLSessionDownloadTask?
    var preView: SongPreview
    
    init(preview: SongPreview) {
        self.preView = preview
    }
}
