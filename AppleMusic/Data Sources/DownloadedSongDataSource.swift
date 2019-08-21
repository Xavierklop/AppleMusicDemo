//
//  DownloadedSongDataSource.swift
//  AppleMusic
//
//  Created by Hao Wu on 19.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

class DownloadedSongDataSource: NSObject, UITableViewDataSource {
    
    private var songs: [SongEntity]
    
    var tableView: UITableView!
    var dataController: DataController!
    
    init(songs: [SongEntity]) {
        self.songs = songs
        super.init()
    }
    
    // Data Scource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DownloadedSongCell.reuseIdentifier, for: indexPath) as! DownloadedSongCell
        // TODO: - Add other properties after add coredata
        let song = songs[indexPath.row]
        cell.songTitleLabel.text = song.name
        cell.albumTitleLabel.text = song.albumName
        cell.artistNameLabel.text = song.artistName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteDownloadedSong(at: indexPath)
        default: ()
        }
    }
    
    // Helper method
    func update(with songs: [SongEntity]) {
        self.songs = songs
    }
}

extension DownloadedSongDataSource {
    func deleteDownloadedSong(at indexPath: IndexPath) {
        let songToDelete = songs[indexPath.row]
        dataController.viewContext.delete(songToDelete)
        do {
            try dataController.viewContext.save()
        } catch {
            print("Can delete song from core data, error: \(error.localizedDescription)")
        }
        songs.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        
        if songs.count == 0 {
            DownloadedSongController().setEditing(false, animated: true)
        }
    }
    

}