//
//  VideoPlayerViewController.swift
//  VideoPlayer
//
//  Created by Arjuna on 5/31/21.
//

import UIKit
import AVFoundation
import Kingfisher

class VideoPlayerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var videoListView: UICollectionView!
    
    static var avPlayer: AVPlayer = AVPlayer()
    var category:VideoCategory!
    var selectedVideoIndex:Int!
    
    var videoCellSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    
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
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//
//        self.videoListView.reloadData()
//        self.videoListView.scrollToItem(at: IndexPath(item: self.selectedVideoIndex, section: 0), at: [.centeredVertically, .centeredHorizontally], animated: false)
//        self.playVideoAtSelectedIndex()
//
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.videoCellSize = self.view.bounds
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        self.videoListView.reloadData()
        self.videoListView.layoutIfNeeded()
        self.videoListView.scrollToItem(at: IndexPath(item: self.selectedVideoIndex, section: 0), at: [.centeredVertically, .centeredHorizontally], animated: false)
        //self.playVideoAtSelectedIndex()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        self.videoListView.reloadData()
        self.videoListView.layoutIfNeeded()
        self.videoListView.scrollToItem(at: IndexPath(item: self.selectedVideoIndex, section: 0), at: [.centeredVertically, .centeredHorizontally], animated: false)
        //self.playVideoAtSelectedIndex()
    }

    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//
//        self.videoListView.reloadData()
//        self.videoListView.scrollToRow(at: IndexPath(row: self.selectedVideoIndex, section: 0), at: .middle, animated: false)
//        self.playVideoAtSelectedIndex()
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        player.pause()
        player.replaceCurrentItem(with:nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.category.videos.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoPlayerCollectionViewCell", for: indexPath) as! VideoPlayerCollectionViewCell
        videoCell.thumbnailImageView.kf.indicatorType = .activity
        
        let provider = AVAssetImageDataProvider(
            assetURL: self.category.videos[indexPath.item].url,
            seconds: 2.0
        )
        let placeholderImage = UIImage(named: "placeholder-image")

        videoCell.thumbnailImageView.kf.setImage(with: provider, placeholder: placeholderImage, options: [.processor(DownsamplingImageProcessor(size: videoCellSize))])
        
        return videoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if player.timeControlStatus == .playing {
            player.pause()
            //btnPlay.setImage(UIImage(named: "control-play"), for: .normal)
        } else if player.timeControlStatus == .paused {
            player.play()
            //btnPlay.setImage(UIImage(named: "control-pause"), for: .normal)
        }
    }
    
    func playVideoAtSelectedIndex() {
        let selectedCell = self.videoListView.cellForItem(at: IndexPath(item: self.selectedVideoIndex, section: 0)) as! VideoPlayerCollectionViewCell
        selectedCell.playerView.avPlayerLayer.player = player
        player.replaceCurrentItem(with: nil)
        player.replaceCurrentItem(with: AVPlayerItem(url: self.category.videos[self.selectedVideoIndex].url))
        player.play()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return videoCellSize
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.category.videos.count
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
        let currentVisbleCell = self.videoListView.visibleCells[0] as! VideoPlayerCollectionViewCell
        self.selectedVideoIndex =  self.videoListView.indexPath(for: currentVisbleCell)?.item
        playVideoAtSelectedIndex()
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

}
