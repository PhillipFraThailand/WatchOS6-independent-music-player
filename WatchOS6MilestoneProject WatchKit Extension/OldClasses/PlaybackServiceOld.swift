//
//  PlaybackService.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 9/11/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//
/*
import Foundation

//MARK:- Protocol
protocol PlaybackServiceProtocolOld {
    func populatePlaylist() -> Void
    func preparePlayer() -> Void
    func playerPlay() -> Void
    func nextTrack() -> Void
    func previousTrack() -> Void
    func replaceCurrentItem(String: [String])
}

//MARK:- Class
class PlaybackServiceOld: PlaybackServiceProtocolOld {
    
//MARK:- Singleton
    static let sharedInstance = PlaybackServiceOld(trackProvider: API())
    
    private init(trackProvider: TrackProviderProtocol) {
        self.trackProvider = trackProvider
        print("PlaybackServiceOld Born")
    }
//MARK:- Variables
    let player = AudioPlayer()
    let trackProvider: TrackProviderProtocol
    var playlist: [String] = []
    var currentSong = 1

//MARK:- Functions
    // Should call the api to load data
    func populatePlaylist() {
        playlist = trackProvider.getData()!
        print("populated playlist with \(playlist)")
    }

    func preparePlayer() {
        player.prepareForPlay(source: playlist[currentSong])
    }
    
    func playerPlay() {
        trackProvider.getData()
        trackProvider.queryForPuplicPlaylists()
 /*     populatePlaylist()
        preparePlayer()
        player.play()
   */ }

// FIXME: Implement
    func nextTrack() {
       print("nextTrack pressed")
       }
    
    func previousTrack() {
        print("prev pressed")
    }
    
    func replaceCurrentItem(String: [String]) {
        print("replacing current track")
    }
}
*/
