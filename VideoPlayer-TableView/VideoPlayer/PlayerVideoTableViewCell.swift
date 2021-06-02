//
//  PlayerVideoTableViewCell.swift
//  VideoPlayer
//
//  Created by Arjuna on 5/31/21.
//

import UIKit
import Foundation

class PlayerVideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var playerView: VideoPlayerCellView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.playerView.avPlayerLayer.player = nil
    }
}
