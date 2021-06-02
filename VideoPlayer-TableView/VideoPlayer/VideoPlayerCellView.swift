//
//  VideoPlayerCellView.swift
//  VideoPlayer
//
//  Created by Arjuna on 5/31/21.
//

import UIKit
import AVFoundation

class VideoPlayerCellView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var avPlayerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

}
