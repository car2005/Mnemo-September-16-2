//
//  UIPlayerView.swift
//  Mnemo
//
//  Created by Ana on 11/9/22.
//

import SwiftUI
import AVKit

class UIVideoPlayer: UIView {
    
    var playerLayer = AVPlayerLayer()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            
            let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "MNEMO", ofType: "mp4")!))
            player.isMuted = true
            player.play()
          
            playerLayer.player = player
            playerLayer.videoGravity = AVLayerVideoGravity(rawValue: AVLayerVideoGravity.resizeAspectFill.rawValue)
            
            layer.addSublayer(playerLayer)
        }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            playerLayer.frame = bounds
        }
    
    struct PlayerView: UIViewRepresentable {
        func makeUIView(context: Context) -> UIVideoPlayer {
            return UIVideoPlayer()
        }
        func updateUIView(_ uiView: UIVideoPlayer, context: Context) {
            
        }
    }
}
