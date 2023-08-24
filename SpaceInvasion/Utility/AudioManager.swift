//
//  AudioManager.swift
//  SpaceInvasion
//
//  Created by MacBook Air on 18.08.2023.
//

import Foundation
import AVFAudio

protocol AudioSetting {
    func setupAudio(resource: String)
    var backingAudio: AVAudioPlayer { get set }
}

enum Compositions: String {
    case spaceInvaders
    case titleScreen
    case activateShields
    case brokenCircuit
    
    func describe() -> String {
        switch self {
        case .spaceInvaders:
            return "space invaders"
        case .titleScreen:
            return "Title Screen"
        case .activateShields:
            return "Activate Shields_1"
        case .brokenCircuit:
            return "Broken Circuit_1"
        }
    }
}

class AudioManager: AudioSetting {
    
    var backingAudio = AVAudioPlayer()
    
    func setupAudio(resource: String) {
        
        let filePath = Bundle.main.path(forResource: resource, ofType: "mp3")
        let audioNSURL = NSURL(fileURLWithPath: filePath!)
        
        do {
            backingAudio = try AVAudioPlayer(contentsOf: audioNSURL as URL)
        }
        catch {
            return print ("Cannot find audio file")
        }
        
        backingAudio.numberOfLoops = -1
        backingAudio.play()
    }
}
