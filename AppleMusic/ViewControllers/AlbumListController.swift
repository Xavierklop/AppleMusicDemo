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
    
    lazy var dataSource: AlbumListDataSource = {
        AlbumListDataSource(albums: [], tableView: self.tableView)
    }()
    
    var dataController: DataController!
    
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
        
        albumDetailController.dataController = dataController
        ItunesClient.lookupAlbum(selectedAlbum ,by: selectedAlbum.id) {[weak self] (album, error) in
            if album != nil {
                albumDetailController.album = album
            } else {
                self?.showAlert(title: "Bad network connection", message: "Please try to search album later.")
            }
        }
        
    }
    
    // MARK: - Helper Methods
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
