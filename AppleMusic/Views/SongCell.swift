//
//  SongCell.swift
//  AppleMusic
//
//  Created by Hao Wu on 26.07.19.
//  Copyright © 2019 Hao Wu. All rights reserved.
//

import UIKit

protocol SongCellDelegate {
    func downloadTapped(_ cell: SongCell)
}

class SongCell: UITableViewCell {
    
    static let reuseIdentifier = "SongCell"
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songRunTimeLabel: UILabel!
    
    var songCellDelegate: SongCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func downloadTapped(_ sender: Any) {
        // TODO: - add to core data
        songCellDelegate.downloadTapped(self)
    }
    
    func configure(with viewModel: SongViewModel) {
        songTitleLabel.text = viewModel.title
        songRunTimeLabel.text = viewModel.runTime
    }

}
