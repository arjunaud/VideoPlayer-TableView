//
//  VideoPlayerCollectionViewCell.swift
//  VideoPlayer
//
//  Created by Arjuna on 5/31/21.
//

import UIKit

class VideoPlayerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var playerView: VideoPlayerCellView!

    override func prepareForReuse() {
        self.playerView.avPlayerLayer.player = nil
    }
}
