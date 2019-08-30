//
//  AlbumDetailController.swift
//  AppleMusic
//
//  Created by Hao Wu on 26.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import CoreData

class AlbumDetailController: UITableViewController {
    
    var dataSource = AlbumDetailDataSource(songs: [])
    var dataController: DataController!
    let previewDownloader = PreviewDownloader()
    // test
    var fetchedResultsController: NSFetchedResultsController<SongEntity>!
    
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier:
            "com.xavierklopwu.appleMusic.demo")
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    var downloadPreview: DownloadPreview?
    
    var album: Album? {
        didSet {
            if let album = album {
                artworkView.image = album.artwork
                self.title = album.name
                configure(with: album)
                dataSource.update(with: album.songs, imageData: album.artworkData)
                tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumGenreTitle: UILabel!
    @IBOutlet weak var albumReleaseDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.dataController = dataController
        previewDownloader.downloadsSession = downloadsSession
        dataSource.previewDownloader = previewDownloader
        dataSource.tableView = tableView
        tableView.dataSource = dataSource
        
        if let album = album {
            configure(with: album)
        }
    }
    
    // test
    fileprivate func setUpFetchedReultsContoller() {
        let fetchRequest: NSFetchRequest<SongEntity> = SongEntity.fetchRequest()
        let sortDescription = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescription]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not performed: \(error.localizedDescription).")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let downloadPreview = downloadPreview else {
            print("No available downloadPreview")
            return
        }
        
        let songPreview = downloadPreview.songPreView
        if songPreview.downloaded {
            playDownload(songPreview)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func playDownload(_ songPreview: SongPreview) {
        let playerViewController = AVPlayerViewController()
        present(playerViewController, animated: true, completion: nil)
        
        let url = localFilePath(for: songPreview.previewURL)
        let player = AVPlayer(url: url)
        playerViewController.player = player
        player.play()
    }
    
    func configure(with album: Album) {
        let viewModel = AlbumDetailViewModel(album: album)
        
        albumTitleLabel.text = viewModel.title
        albumGenreTitle.text = viewModel.genre
        albumReleaseDateLabel.text = viewModel.releaseDate
    }
    
    func localFilePath(for url: URL) -> URL {
        return documentsPath.appendingPathComponent(url.lastPathComponent)
    }

}

// MARK: - URL Session Delegate
extension AlbumDetailController: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let completionHandler = appDelegate.backgroundSessionCompletionHandler {
                appDelegate.backgroundSessionCompletionHandler = nil
                completionHandler()
            }
        }
    }
}

// MARK: - URL Session Download Delegate
extension AlbumDetailController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        guard let sourceURL = downloadTask.originalRequest?.url else {
            print("downloadTask has no source url")
            return
        }
        
        let download = previewDownloader.activeDownloads[sourceURL]
        previewDownloader.activeDownloads[sourceURL] = nil
        downloadPreview = download
        
        let destinationURL = localFilePath(for: sourceURL)
        // test
        print("destinationURL is \(destinationURL)")
        
        let fileManger = FileManager.default
        try? fileManger.removeItem(at: destinationURL)
        
        do {
            try fileManger.copyItem(at: location, to: destinationURL)
            download?.songPreView.downloaded = true
        } catch {
            print("Could not copy file to disk: \(error.localizedDescription)")
        }
        // test
        setUpFetchedReultsContoller()
        guard let results = fetchedResultsController.fetchedObjects else {
            print("No results in fetchedResultsController.fetchedObjects")
            return
        }
        
        if let index = download?.songPreView.index {
            // test
            results.forEach {
                if let urlString = $0.previewURL {
                    if urlString == String(describing: sourceURL) {
                        print("find songEntity")
                        $0.previewDestinationURL = String(describing: destinationURL)
                        print("destinationURL is \n\($0.previewDestinationURL)")
                    }
                }
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            }
        }
        // test
        fetchedResultsController = nil
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        guard let url = downloadTask.originalRequest?.url, let download = previewDownloader.activeDownloads[url] else {
            return
        }
        
        download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        
        let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
        
        DispatchQueue.main.async {
            if let songCell = self.tableView.cellForRow(at: IndexPath(row: download.songPreView.index, section: 0)) as? SongCell {
                songCell.updateDownloadProgress(progress: download.progress, totalSize: totalSize)
            }
        }
    }
}
