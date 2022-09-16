//
//  ShoulderToShoulder.swift
//  Mnemo
//
//  Created by Ana on 11/9/22.
//

import Foundation
import AVFoundation

var audioplayer: AVAudioPlayer!

func playSound() {
    let audiourl = Bundle.main.url(forResource: "ShoulderToShoulder", withExtension: "m4a")
    
    guard audiourl != nil else {
        return
    }
    
    do {
        audioplayer = try AVAudioPlayer(contentsOf: audiourl!)
        audioplayer?.play()
    } catch {
        print("error")
    }
}
