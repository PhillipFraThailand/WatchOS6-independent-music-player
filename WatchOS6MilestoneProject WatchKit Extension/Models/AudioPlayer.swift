//
//  AudioPlayer.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 9/11/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import Foundation
import AVFoundation
import Combine

//MARK: Protocol
protocol AudioPlayerProtocol {
    func actionatItemEnd() -> Void
}

class AudioPlayer: NSObject, AudioPlayerProtocol, ObservableObject {
    
// MARK: Properties
    var player: AVPlayer?
    var source: String?
    var url: URL?
    var asset: AVAsset?
    var playerItem: AVPlayerItem?
    let session = AVAudioSession.sharedInstance()

// MARK: Observers & Observerable
    var errorObservation: NSKeyValueObservation?
    var timeControlStatusObservation: NSKeyValueObservation?
    var timeObservation: Any?
    
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    var timeControlStatus: AVPlayer.TimeControlStatus? {
        didSet {
            print("timeControlStatus changed")
            objectWillChange.send(self)
            }
    }
    
//MARK: init
    override init() {
        print("AudioPlayer init")
    }
    
//MARK: Functions
    func play() {
        self.player?.play()
    }
    
    func playerPause() {
        player?.pause()
    }
    
    func actionatItemEnd() {
        print("queue ended make action")
    }
    
    func replacePlayerItem() {
        player?.replaceCurrentItem(with: self.playerItem)
    }
    
//MARK: Observers
    func addObserver() {
        errorObservation?.invalidate()
        errorObservation = player?.observe(\AVPlayer.error) { [weak self] player, change in
            print("Error \(String(describing: self?.player?.error))")
        }
        timeControlStatusObservation?.invalidate()
        timeControlStatusObservation = player?.observe(\AVPlayer.timeControlStatus) { [weak self] player, change in
            print("timeControlStatus \(String(describing: self?.player?.timeControlStatus))")
        }
        if let to = timeObservation {
            player?.removeTimeObserver(to)
            timeObservation = nil
        }
        timeObservation = player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 10), queue: DispatchQueue.main) { time in
            print("Time \(time)")
        }
    }
    
    func removeObservers() {
        print("removed observers")
        errorObservation?.invalidate()
        timeControlStatusObservation?.invalidate()
        if let to = timeObservation {
            player?.removeTimeObserver(to)
            timeObservation = nil
        }
    }
    deinit {
        errorObservation?.invalidate()
        timeControlStatusObservation?.invalidate()
        
        if let to = timeObservation {
            player?.removeTimeObserver(to)
            timeObservation = nil
        }
    }
}
