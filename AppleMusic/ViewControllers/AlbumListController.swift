//
//  AlbumListController.swift
//  AppleMusic
//
//  Created by Hao Wu on 25.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

class AlbumListController: UITableViewController {

    private struct Constants {
        static let AlbumCellHeight: CGFloat = 80
    }
    
    var artist: Artist!
    lazy var dataSource: AlbumListDataSource = {
        return AlbumListDataSource(albums: self.artist.albums)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = artist.name
        tableView.dataSource = dataSource
    }

    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.AlbumCellHeight
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showAlbum" else {
            print("No selected album")
            return
        }
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
            print("No selected row")
            return
        }
        let selectedAlbum = dataSource.album(at: selectedIndexPath)
        selectedAlbum.songs = Stub.songs
        
        let albumDetailController = segue.destination as! AlbumDetailController
        albumDetailController.album = selectedAlbum
        
    }
    
}
