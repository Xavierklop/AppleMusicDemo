//
//  AlbumDetailController.swift
//  AppleMusic
//
//  Created by Hao Wu on 26.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

class AlbumDetailController: UITableViewController {
    
    var dataSource = AlbumDetailDataSource(songs: [])
    var dataController: DataController!
    let previewDownloader = PreviewDownloader()
    
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier:
            "com.xavierwu.appleMusicDemo")
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
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

    func configure(with album: Album) {
        let viewModel = AlbumDetailViewModel(album: album)
        
        albumTitleLabel.text = viewModel.title
        albumGenreTitle.text = viewModel.genre
        albumReleaseDateLabel.text = viewModel.releaseDate
    }

}

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
