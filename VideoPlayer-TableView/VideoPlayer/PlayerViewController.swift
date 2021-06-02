//
//  PlayerViewController.swift
//  VideoPlayer
//
//  Created by Arjuna on 5/31/21.
//

import UIKit
import AVFoundation
import AVKit
import Kingfisher


class PlayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    static var avPlayer: AVPlayer = AVPlayer()
    var category:VideoCategory!
    var selectedVideoIndex:Int!
    
    var videoCellSize:CGSize!// = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    @IBOutlet weak var videoListView: UITableView!
    
    var player: AVPlayer {
        get {
            return PlayerViewController.avPlayer
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //videoListView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.videoCellSize = self.view.bounds.size
        videoListView.tableHeaderView?.frame = CGRect.zero

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        self.videoListView.reloadData()
//        self.videoListView.contentOffset = CGPoint(x:self.videoListView.contentOffset.x, y: videoCellSize.height * CGFloat(self.selectedVideoIndex))
        self.videoListView.scrollToRow(at: IndexPath(row: self.selectedVideoIndex, section: 0), at: .middle, animated: false)
        self.playVideoAtSelectedIndex()

    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        videoListView.tableHeaderView?.frame = CGRect.zero
//
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//
//        self.videoListView.reloadData()
//        self.videoListView.scrollToRow(at: IndexPath(row: self.selectedVideoIndex, section: 0), at: .middle, animated: false)
//        self.playVideoAtSelectedIndex()
//
//    }
//
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        player.pause()
        player.replaceCurrentItem(with:nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.category.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let videoCell = tableView.dequeueReusableCell(withIdentifier: "PlayerVideoTableViewCell", for: indexPath) as! PlayerVideoTableViewCell
        videoCell.thumbnailImageView.kf.indicatorType = .activity
        
        let provider = AVAssetImageDataProvider(
            assetURL: self.category.videos[indexPath.item].url,
            seconds: 2.0
        )
        let placeholderImage = UIImage(named: "placeholder-image")

        videoCell.thumbnailImageView.kf.setImage(with: provider, placeholder: placeholderImage, options: [.processor(DownsamplingImageProcessor(size: videoCellSize))])
        
        return videoCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.videoCellSize.height
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentVisbleCell = self.videoListView.visibleCells[0] as! PlayerVideoTableViewCell
        self.selectedVideoIndex =  self.videoListView.indexPath(for: currentVisbleCell)?.row
        playVideoAtSelectedIndex()
    }
    
    func playVideoAtSelectedIndex() {
        let selectedCell = self.videoListView.cellForRow(at: IndexPath(row: self.selectedVideoIndex, section: 0)) as! PlayerVideoTableViewCell
        selectedCell.playerView.avPlayerLayer.player = player
        player.replaceCurrentItem(with: nil)
        player.replaceCurrentItem(with: AVPlayerItem(url: self.category.videos[self.selectedVideoIndex].url))
        player.play()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if player.timeControlStatus == .playing {
            player.pause()
            //btnPlay.setImage(UIImage(named: "control-play"), for: .normal)
        } else if player.timeControlStatus == .paused {
            player.play()
            //btnPlay.setImage(UIImage(named: "control-pause"), for: .normal)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }

}
