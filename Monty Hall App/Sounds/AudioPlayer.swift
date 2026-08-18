//
//  AudioPlayer.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 02/11/21.
//

import AVFoundation

let audioManager = AudioManager()

// MARK: - AudioManager

/// Singleton audio manager handling background music playback
final class AudioManager {

    // MARK: - Properties

    var player = AVAudioPlayer()

    // MARK: - Playback Controls

    /// Plays sound media with optional loop count (-1 for infinite loop)
    /// - Parameters:
    ///   - media: Media resource to play
    ///   - numberOfLoops: Number of repeat loops (default is -1 for continuous looping)
    func play(_ media: Media, numberOfLoops: Int = -1) {
        if let bundlePath = Bundle.main.path(forResource: media.title, ofType: media.type) {
            let soundURL = URL(fileURLWithPath: bundlePath)
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
                player.numberOfLoops = numberOfLoops
                player.prepareToPlay()
                player.play()
            } catch {
                print(error)
            }
        }
    }

    /// Toggles music between play and pause states
    func toggleMusic() {
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
    }
}

// MARK: - Tracklist

/// Collection of audio track definitions
struct Tracklist {
    static let soundtrack = Media(title: "soundtrack", type: "mp3")
}

