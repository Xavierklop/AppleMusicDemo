//
//  AlbumDetailDataSource.swift
//  AppleMusic
//
//  Created by Hao Wu on 26.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import Foundation
import UIKit

class AlbumDetailDataSource: NSObject, UITableViewDataSource {
    private var songs: [Song]
    // test
    private var imageData: Data?
    
    var dataController: DataController!
    
    init(songs: [Song]) {
        self.songs = songs
        super.init()
    }
    
    // MARK: - Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let songCell = tableView.dequeueReusableCell(withIdentifier: SongCell.reuseIdentifier, for: indexPath) as! SongCell
        songCell.songCellDelegate = self
        
        let song = songs[indexPath.row]
        let viewModel = SongViewModel(song: song)
        songCell.configure(with: viewModel)
        
        return songCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Track"
        default: return nil
        }
    }
    
    // MARK: - Helper Metherds
    func update(with songs: [Song], imageData: Data?) {
        self.songs = songs
        self.imageData = imageData
    }
}

extension AlbumDetailDataSource: SongCellDelegate {
    func downloadTapped(_ cell: SongCell) {
        if let indexPath = cell.indexPath {
            let song = songs[indexPath.row]
            let songEntity = SongEntity(context: dataController.viewContext)
            songEntity.creationDate = Date()
            songEntity.censoredName = song.censoredName
            songEntity.name = song.name
            songEntity.id = Int32(song.id)
            songEntity.isExplicit = song.isExplicit
            songEntity.trackTime = Int32(song.trackTime)
            songEntity.artistName = song.artistName
            songEntity.albumName = song.albumName
            if let imageData = imageData {
                    songEntity.artworkData = imageData
            }
        
            do {
                try dataController.viewContext.save()
            } catch {
                print("save song to core data failed, error: \(error.localizedDescription)")
            }
        
        }
    }
}
