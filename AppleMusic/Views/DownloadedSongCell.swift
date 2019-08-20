//
//  DownloadedSongCell.swift
//  AppleMusic
//
//  Created by Hao Wu on 19.08.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

class DownloadedSongCell: UITableViewCell {
    
    static let reuseIdentifier = "DownloadedSongCell"
    
    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configre(with viewModel: DownloadedSongViewModel) {
        songTitleLabel.text = viewModel.songTitle
        artistNameLabel.text = viewModel.artistTitle
        albumTitleLabel.text = viewModel.albumTitle
        // TODO: - add artworkView.image when finish CoreData
    }
}
