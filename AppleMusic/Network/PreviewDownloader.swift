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
        
        let download = DownloadPreview(preview: songPreview)
        
        download.task = downloadsSession.downloadTask(with: songPreview.previewURL)
        download.task?.resume()
        download.isDownloading = true
        
        activeDownloads[download.songPreView.previewURL] = download
    }
    
    func cancelDownload(_ songPreview: SongPreview) {
        guard let download = activeDownloads[songPreview.previewURL] else {
            print("No activite for preview url: \(songPreview.previewURL) in activeDownloads when cancelDownload")
            return
        }
        
        download.task?.resume()
        activeDownloads[songPreview.previewURL] = nil
    }
    
    func pauseDownload(_ songPreview: SongPreview) {
        guard let download = activeDownloads[songPreview.previewURL] else {
            print("No activite for preview url: \(songPreview.previewURL) in activeDownloads when pauseDownload")
            return
        }
        download.task?.cancel(byProducingResumeData: { (data) in
            download.resumeData = data
        })
        
        download.isDownloading = false
    }
    
    func resumeDownload(_ songPreview: SongPreview) {
        guard let download = activeDownloads[songPreview.previewURL] else {
            print("No activite for preview url: \(songPreview.previewURL) in activeDownloads when resumeDownload")
            return
        }
        
        if let resumeData = download.resumeData {
            download.task = downloadsSession.downloadTask(withResumeData: resumeData)
        } else {
            download.task = downloadsSession.downloadTask(with: download.songPreView.previewURL)
        }
        
        download.task?.resume()
        download.isDownloading = true
    }
}
