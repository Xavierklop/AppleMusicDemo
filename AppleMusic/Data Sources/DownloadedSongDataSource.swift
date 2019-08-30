//
//  DownloadedSongDataSource.swift
//  AppleMusic
//
//  Created by Hao Wu on 19.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit
import CoreData

class DownloadedSongDataSource: NSObject, UITableViewDataSource {
    
    var tableView: UITableView!
    var dataController: DataController!
    var fetchedResultsController: NSFetchedResultsController<SongEntity>!
    
    // Data Scource
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let downloadedSongCell = tableView.dequeueReusableCell(withIdentifier: DownloadedSongCell.reuseIdentifier, for: indexPath) as! DownloadedSongCell
        
        let songEntity = fetchedResultsController.object(at: indexPath)
        downloadedSongCell.songTitleLabel.text = songEntity.name
        downloadedSongCell.albumTitleLabel.text = songEntity.albumName
        downloadedSongCell.artistNameLabel.text = songEntity.artistName
        if let artworkData = songEntity.artworkData {
            downloadedSongCell.artworkView.image = UIImage(data: artworkData)
        }
        // test
        print("songEntity destinationURL is \(songEntity.previewDestinationURL)")
        
        return downloadedSongCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            deleteDownloadedSong(at: indexPath)
        default: ()
        }
    }
    
}

extension DownloadedSongDataSource {
    func deleteDownloadedSong(at indexPath: IndexPath) {
        let songToDelete = fetchedResultsController.object(at: indexPath)
        dataController.viewContext.delete(songToDelete)
        do {
            try dataController.viewContext.save()
        } catch {
            print("Can delete song from core data, error: \(error.localizedDescription)")
        }        
    }

}
