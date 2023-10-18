//
//  VideoPlayerView.swift
//  InlineVideoPlayer
//
//  Created by Yoshimasa Niwa on 10/18/23.
//

import AVKit
import UIKit

final class VideoPlayerView: UIView {
    private var playerLayer: AVPlayerLayer?
    private var looper: AVPlayerLooper?

    var videoURL: URL? {
        didSet {
            guard oldValue != videoURL else {
                return
            }

            guard let videoURL = videoURL else {
                playerLayer?.removeFromSuperlayer()
                playerLayer = nil
                looper = nil
                return
            }

            let playerItem = AVPlayerItem(url: videoURL)
            let player = AVQueuePlayer(playerItem: playerItem)

            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = .resizeAspectFill
            playerLayer.frame = bounds
            layer.addSublayer(playerLayer)
            self.playerLayer = playerLayer

            let looper = AVPlayerLooper(player: player, templateItem: playerItem)
            self.looper = looper

            player.play()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        playerLayer?.frame = bounds
    }
}
