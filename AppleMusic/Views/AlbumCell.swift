//
//  AlbumCell.swift
//  AppleMusic
//
//  Created by Hao Wu on 25.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {

    static let reuseIdentifier = "AlbumCell"
    
    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var genreTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel: AlbumCellViewModel) {
        albumTitleLabel.text = viewModel.title
        genreTitleLabel.text = viewModel.genre
        releaseDateLabel.text = viewModel.releaseDate
    }

}
