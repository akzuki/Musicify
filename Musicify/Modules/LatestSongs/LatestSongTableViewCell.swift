//
//  LatestSongTableViewCell.swift
//  Musicify
//
//  Created by Hai Phan on 02/01/2019.
//  Copyright © 2019 Hai Phan. All rights reserved.
//

import UIKit
import Kingfisher

class LatestSongTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    
    // MARK: - View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(song: Song) {
        thumbnailImageView.kf.setImage(with: song.thumbnailURL)
        artistLabel.text = song.artist
        releaseYearLabel.text = song.releaseYear
        songNameLabel.text = song.name
    }

}
