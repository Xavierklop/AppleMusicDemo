//
//  AlbumListDataSource.swift
//  AppleMusic
//
//  Created by Hao Wu on 25.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

class AlbumListDataSource: NSObject, UITableViewDataSource {
    
    private var albums: [Album]
    let pendingOperations = PendingOperations()
    let tableView: UITableView
    
    init(albums: [Album], tableView: UITableView) {
        self.albums = albums
        self.tableView = tableView
        super.init()
    }
    
    // MARK: - Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.reuseIdentifier, for: indexPath) as! AlbumCell
        
        let album = albums[indexPath.row]
        let viewModel = AlbumCellViewModel(album: album)
        cell.configure(with: viewModel)
        cell.accessoryType = .disclosureIndicator
        
        if album.artworkState == .placeholder {
            downloadAlbumArtwork(by: album, at: indexPath)
        }
        
        return cell
    }
    
    // Helper Metheds
    func album(at indexPath: IndexPath) -> Album {
        return albums[indexPath.row]
    }
    
    func update(with albums: [Album]) {
        self.albums = albums
    }
    
    func downloadAlbumArtwork(by album: Album, at indexPath: IndexPath) {
        if let _ = pendingOperations.downloadInProcess[indexPath] {
            return
        }
        
        let downloader = ArtworkDownloader(album: album)
        pendingOperations.downloadInProcess[indexPath] = downloader
        pendingOperations.downQueue.addOperation(downloader)
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                self.pendingOperations.downloadInProcess.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
