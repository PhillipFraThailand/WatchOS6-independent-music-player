//
//  playPauseButtonView.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 10/15/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import SwiftUI

struct PlayPauseButtonView: View {
    
    @ObservedObject var PS = PlaybackService.sharedInstance
    
    fileprivate func playPauseButtonPress() -> Button<Image> {
        if !PlaybackService.sharedInstance.isPlaying {
            return Button(action: PS.playerPlay) {
                Image(systemName: PS.isPlaying ? "pause" : "play")
            }
        } else {
            return Button(action: PlaybackService.sharedInstance.playerPause) {
            Image(systemName: PlaybackService.sharedInstance.isPlaying ? "pause" : "play")
            }
        }
    }
    
    var body: some View {
        playPauseButtonPress()
    }
}

struct playPauseButtonView_Previews: PreviewProvider {
    static var previews: some View {    
        PlayPauseButtonView()
    }
}
