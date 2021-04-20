//
//  SoundHelper.swift
//  BookCore
//
//  Created by Albert Rayneer on 08/04/21.
//

import Foundation
import AVFoundation

class SoundHelper {
    static let instance = SoundHelper()
    public var audioPlayer: AVAudioPlayer!

    public func playSound(resource: String) {
        guard let soundURL = Bundle.main.url(forResource: resource, withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
        }
        catch {
            print(error)
        }
        audioPlayer.play()
    }
}
