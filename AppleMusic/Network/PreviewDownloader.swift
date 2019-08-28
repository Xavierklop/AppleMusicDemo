//
//  PreviewDownloader.swift
//  AppleMusic
//
//  Created by Hao Wu on 26.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation

class PreviewDownloader {
    
    var activeDownloads: [URL: DownloadPreview] = [ : ]
    var downloadsSession: URLSession!
    
    func startDownload(_ songPreview: SongPreview) {
        
        let downloadPreview = DownloadPreview(preview: songPreview)
        
        downloadPreview.task = downloadsSession.downloadTask(with: songPreview.previewURL)
        downloadPreview.task?.resume()
        downloadPreview.isDownloading = true
        
        activeDownloads[downloadPreview.songPreView.previewURL] = downloadPreview
    }
}
