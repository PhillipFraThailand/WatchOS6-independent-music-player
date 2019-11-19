//
//  API.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 9/30/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//
/*

import Foundation
import APIClient
import PromiseKit


class API: TrackProviderProtocol {

    func getData() -> [String]? {
        
        if !Session.isSetup {
            Session.setup(configuration: DefaultConfiguration(), settings: DefaultSettings(), authenticator: DefaultOAuthAuthenticator(settings: DefaultSettings()))
        }
//        gets tracks -> tracksPrevies for playbackservice : spinner to show its loading before player is showed
//        when press play: playbackservice comes into play and it shouldve gotten list of [trackspreviews]
//        internally hold the info of what i want to play.
//        playbackservice should notify everyone that its ready to play a track (prolly the first one)
//        
        _ = firstly {
            try Session.instance.getPortalHome()
        }.then {
            try $0.getCatalogHome()
        }.then {
            try $0.getCharts()
        }.map {
            $0.charts.first { $0.isTrackChart == true } // { $0.isAlbumChart == true }
        }.then {
            try $0!.getTrackChart()                     // try $0!.getAlbumChart()
        }.map {
            $0.tracks
        }.done { albums in
            print(albums)
        }
        
        return nil
    }
    
    
    func queryForPuplicPlaylists() {
    }
    
    
}
*/
