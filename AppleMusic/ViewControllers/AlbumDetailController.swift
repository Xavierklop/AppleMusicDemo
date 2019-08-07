//
//  AlbumDetailController.swift
//  AppleMusic
//
//  Created by Hao Wu on 26.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

class AlbumDetailController: UITableViewController {
    
    var album: Album?
    
    lazy var dataSource: AlbumDetailDataSource = {
        return AlbumDetailDataSource(songs: self.album!.songs)
    }()
    
    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumGenreTitle: UILabel!
    @IBOutlet weak var albumReleaseDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
