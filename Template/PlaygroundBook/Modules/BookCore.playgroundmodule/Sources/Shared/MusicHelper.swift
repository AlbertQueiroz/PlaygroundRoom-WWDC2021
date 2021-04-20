//
//  MusicHelper.swift
//  BookCore
//
//  Created by Albert Rayneer on 15/04/21.
//

import Foundation
import AVFoundation

class MusicHelper {
    static var audioPlayer: AVAudioPlayer!
    
    static func playBackgroundMusic() {
        guard audioPlayer == nil else { return }
        if let musicURL = Bundle.main.url(forResource: "music", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: musicURL)
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.volume = 0.2
            } catch {
                print("Unable to play music: \(error.localizedDescription)")
            }
        } else {
            print("Unable to find music file")
        }
        if !UserDefaults.standard.bool(forKey: "isPlaying") {
            playMusic()            
        }
    }
    
    static func playMusic() {
        audioPlayer.play()
        UserDefaults.standard.setValue(true, forKey: "isPlaying")
    }
    
    static func stopMusic() {
        audioPlayer.stop()
    }
}
