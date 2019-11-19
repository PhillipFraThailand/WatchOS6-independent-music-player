//
//  PlaybackService.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 10/3/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import Foundation
import PromiseKit
import AVFoundation
import APIClient
import Combine

class PlaybackService: ObservableObject {
//MARK: Singleton
        static let sharedInstance = PlaybackService()
        private init() {
        self.player = AudioPlayer()
    }

//MARK: Properties
    var startFrom = 0
    let player: AudioPlayer?
    let session = AVAudioSession.sharedInstance()
    var isPlaying = false { //Notify people abt playing. @state is for views and private generally. @environmentobject is global. we just need to notify
        didSet {
            print("isPlaying: \(self.isPlaying)")
            objectWillChange.send(self)
        }
    }
    let objectWillChange = PassthroughSubject<PlaybackService, Never>()
    var trackPreviewList: [TrackPreview]? {
        didSet {
            print("didset trackPreviewList")
            objectWillChange.send(self)
        }
    }
    
//MARK: Functions
    func playerPlay() {
        isPlaying = true
        let playerStatus = player?.player?.status
        
        switch playerStatus {
            case .unknown:
                preparePlaybackURL(startFrom: self.startFrom)
                print("PLAYERSTATUS: \(String(describing: playerStatus?.rawValue))")

            case .readyToPlay:
                player?.play()
                print("PLAYERSTATUS: \(String(describing: playerStatus?.rawValue))")
           
            case .failed:
                print("PLAYERSTATUS: \(String(describing: playerStatus?.rawValue))")
        
            case .none:
                print("PLAYERSTATUS: \(String(describing: playerStatus?.rawValue))")
                preparePlaybackURL(startFrom: self.startFrom)
        
            case .some(_):
                print("PLAYERSTATUS: \(String(describing: playerStatus?.rawValue))")
        }
    }

    func playerPause() {
        player?.playerPause()
        isPlaying = false
    }
    
    func playerSkipForward() {
        if startFrom < ((trackPreviewList!.underestimatedCount)-1) {
            startFrom += 1
            print(startFrom)
            _ = firstly {
                TracklistProvider.sharedInstance.getPlaybackURL(trackPreview: trackPreviewList![startFrom])
            }.map { playbackoptions in
                self.createPlayerItemFromLink(assetURL: (playbackoptions?.playbackUrl)!)
            }.done {
                self.player?.replacePlayerItem()
            }
        } else {
            print("reached end of list, get new chartspage")
        }
    }
    
    func playerskipBackward(){
        if startFrom >= 1 {
            startFrom -= 1
            _ = firstly {
                TracklistProvider.sharedInstance.getPlaybackURL(trackPreview: trackPreviewList![startFrom])
            }.map { playbackoptions in
                self.createPlayerItemFromLink(assetURL: (playbackoptions?.playbackUrl)!)
            }.done {
                self.player?.replacePlayerItem()
            }
        }  else {
           print("reached start of list")
        }
    }
    
    func speakerButton() {
        print("speakerButton()")
    }
    
    func preparePlayerForPlay(sourceURL: URL) {
        player?.removeObservers()
        setupAudioSession()
        setupAudioRouting()
        createPlayerItemFromLink(assetURL: sourceURL)
        createPlayer()
        player?.addObserver()
    }
    
    func createPlayerItemFromLink(assetURL: URL) {
        player?.asset = AVAsset(url: assetURL)
        player?.playerItem = AVPlayerItem(asset: (player?.asset)!)
    }
    
    func createPlayer() {
        player?.player = AVPlayer(playerItem: player?.playerItem)
    }
    
    func setupAudioSession() {
           do {
               try session.setCategory(AVAudioSession.Category.playback, mode: .default, policy: .longFormAudio, options: [])
           } catch let error {
               fatalError("Could not set audiosession \(error.localizedDescription)")
           }
       }
    
    func setupAudioRouting() {
        AVAudioSession.sharedInstance().activate(options: []) { (success, error)  in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            self.player?.play()
        }
    }
    
    func prepareTrackPreviewPromises() {
          let trackPreviewList = TracklistProvider.sharedInstance.getTrackPreviewPromises()
          _ = trackPreviewList.done { trackPreviews in
              print("Loaded trackPreviews")
              self.trackPreviewList = trackPreviews
          }
          
      }
    
      func preparePlaybackURL(startFrom: Int?) {
          firstly {
              TracklistProvider.sharedInstance.getPlaybackURL(trackPreview: trackPreviewList![startFrom ?? 0])
          }.done { playbackoption in
              self.preparePlayerForPlay(sourceURL: (playbackoption?.playbackUrl)!)
          }.catch { (error) in
              print(error)
         }
      }
    
}
