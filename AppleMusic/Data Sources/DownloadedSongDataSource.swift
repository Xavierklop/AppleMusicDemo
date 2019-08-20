//
//  DownloadedSongDataSource.swift
//  AppleMusic
//
//  Created by Hao Wu on 19.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

class DownloadedSongDataSource: NSObject, UITableViewDataSource {
    
    private var songs: [Song]
    
    init(songs: [Song]) {
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
        
        return cell
    }
    
    // Helper method
    func update(with songs: [Song]) {
        self.songs = songs
    }
}
