//
//  TracklistProvider.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 10/3/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import Foundation
import APIClient
import PromiseKit
import SwiftUI
import Combine

protocol PlaybackURLProviderProtocol {
    func getPlaybackURLs(trackPreview: TrackPreview) -> Promise<Void>?
}
protocol TracklistProviderProtocol {
   func getTrackPreviewPromises() -> Promise<[TrackPreview]>
}

class TracklistProvider: TracklistProviderProtocol, /*PlaybackURLProviderProtocol,*/ ObservableObject {
//MARK: SINGLETON
    static let sharedInstance = TracklistProvider()
    private init() {
        print("TrackProvider init")
    }
//MARK: Properties
    var trackPreviews: Promise<[TrackPreview]>?
    var artistName: String? {
        didSet {
                print("artistName: \(String(describing: artistName ))")
                objectWillChange.send(self)
               }
    }
    
    var trackName: String? {
        didSet {
            print("trackName: \(String(describing: trackName))")
            objectWillChange.send(self)
        }
    }

//MARK: Observable
    let objectWillChange = PassthroughSubject<TracklistProvider, Never>()
    var isLoading = false {
        didSet {
            print("didset isLoading to \(self.isLoading)")
            objectWillChange.send(self)
        }
    }
    
//MARK: Functions
    func getTrackPreviewPromises() -> Promise<[TrackPreview]> {
        isLoading = true
        if !Session.isSetup {
                   Session.setup(configuration: DefaultConfiguration(), settings: DefaultSettings(), authenticator: DefaultOAuthAuthenticator(settings: DefaultSettings()))
               }
        let promiseOfTracks : Promise<[TrackPreview]> = firstly {
                   try Session.instance.getPortalHome()
               }.then {
                   try $0.getCatalogHome()
               }.then {
                   try $0.getCharts()
               }.map {
                   $0.charts.first { $0.isTrackChart == true }   // { $0.isAlbumChart == true }
               }.then {
                   try $0!.getTrackChart()                       // try $0!.getAlbumChart()
               }.map {
                 print("Loaded previews")
                return $0.tracks //Might be v stupid to return here
        }.ensure {
            self.isLoading = false
        }
        return promiseOfTracks
    }
    
    func getPlaybackURL(trackPreview: TrackPreview) -> Promise<PlaybackOption?> {
        self.setArtistMeta(trackPreview: trackPreview)
        if !Session.instance.oauthAuthenticator.isLoggedIn {
            return firstly {
                try! Session.instance.oauthAuthenticator.login(PortalTokenRequest(withUsername: "youseemusikvip232", password: "Play1234"))
                }.then {
                    try trackPreview.getPlaybackOptions(forSamples: false)
                }.map { playbackoptions in
                    let po = playbackoptions.httpOptions?.first { $0.bitrateInKbps == 192 }
                    print("playbackUrl: \(String(describing: po?.playbackUrl))")
                    return po
                }.ensure {
                    self.setArtistMeta(trackPreview: trackPreview)
            }
            
        } else {
            return firstly {
                try trackPreview.getPlaybackOptions(forSamples: false)
            } .map { playbackoptions in
                let po = playbackoptions.httpOptions?.first { $0.bitrateInKbps == 192 }
                print("playbackUrl: \(String(describing: po?.playbackUrl))")
                return po
            }.ensure {
                self.setArtistMeta(trackPreview: trackPreview)
            }
        }
    }
    
    func setArtistMeta(trackPreview: TrackPreview) {
        self.artistName = trackPreview.artistName
        self.trackName = trackPreview.name
    }
    
    func setArtistNameAndTrackName(artistName: String, trackName: String) {
        self.artistName = artistName
        self.trackName = trackName
    }
}
                

//    func getPlaybackURLss(trackPreview: TrackPreview) -> Promise<PlaybackOption>{
//           let track = trackPreview
//            firstly {
//
//                let loginPromise = try! Session.instance.oauthAuthenticator.login(PortalTokenRequest(withUsername: "youseemusikvip232", password: "Play1234"))
//
//                loginPromise.done {
//                    try track.getPlaybackOptions(forSamples: false).done { playbackoptions in
//                        let po = playbackoptions.httpOptions?.first { $0.bitrateInKbps == 192 }
//                       print("playbackUrl: \(String(describing: po?.playbackUrl))")
//                    }
//                }
//            }
//            .catch({ (error) in
//            print(error)
//           })
//       }
//
//    func getPlaybackURLss(trackPreview: TrackPreview) -> Promise<PlaybackOption?> {
//          return firstly {
//              try trackPreview.getPlaybackOptions(forSamples: false)
//          }.map { playbackoptions in
//              playbackoptions.httpOptions?.first { $0.bitrateInKbps == 192 }
//          }
//      }

