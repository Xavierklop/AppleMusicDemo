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
    
    var dataSource = AlbumListDataSource(albums: [])
    
    var artist: Artist? {
        didSet {
            self.title = artist?.name
            dataSource.update(with: artist!.albums)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let albumDetailController = segue.destination as! AlbumDetailController
        
        ItunesClient.lookupAlbum(by: selectedAlbum.id) { (album, error) in
            albumDetailController.album = album
        }
        
    }
    
}
