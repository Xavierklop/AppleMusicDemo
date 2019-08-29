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
    func cancelTapped(_ cell: SongCell)
    func pauseTapped(_ cell: SongCell)
    func resumeTapped(_ cell: SongCell)
}

class SongCell: UITableViewCell {
    
    static let reuseIdentifier = "SongCell"
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songRunTimeLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
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
        songCellDelegate.downloadTapped(self)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        songCellDelegate.cancelTapped(self)
    }
    
    @IBAction func pauseOrResumeTapped(_ sender: Any) {
        if pauseButton.titleLabel?.text == "Pause" {
            songCellDelegate.pauseTapped(self)
        } else {
            songCellDelegate.resumeTapped(self)
        }
    }
    
    // MARK: - Helper Methods
    func configure(with viewModel: SongViewModel, songPreview: SongPreview, downloaded: Bool, downloadPreview: DownloadPreview?) {
        songTitleLabel.text = viewModel.title
        songRunTimeLabel.text = viewModel.runTime
        
        var showDownloadControls = false
        
        if let downloadPreview = downloadPreview {
            showDownloadControls = true
            
            let title = downloadPreview.isDownloading ? "Pause" : "Resume"
            pauseButton.setTitle(title, for: .normal)
            progressLabel.text = downloadPreview.isDownloading ? "Downloading..." : "Paused"
        }
        pauseButton.isHidden = !showDownloadControls
        cancelButton.isHidden = !showDownloadControls
        progressLabel.isHidden = !showDownloadControls
        progressView.isHidden = !showDownloadControls
        
        selectionStyle = downloaded ? UITableViewCell.SelectionStyle.gray : UITableViewCell.SelectionStyle.none
        downloadButton.isHidden = downloaded || showDownloadControls
    }

    func updateDownloadProgress(progress: Float, totalSize: String) {
        progressView.progress = progress
        progressLabel.text = String(format: "%.1f%% of %@", progress * 100, totalSize)
    }
}
