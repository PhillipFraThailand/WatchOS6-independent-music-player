//
//  PlayerView.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 9/11/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import SwiftUI
import AVFoundation

struct PlayerView: View {
    var body: some View {
//MARK:- Layer
        VStack {
            Spacer()
            ArtistTrackView()
            Spacer()
            
//MARK:- Layer
            HStack {
                Spacer()
                BackwardEndButtonView()
                Spacer()
                PlayPauseButtonView()
                Spacer()
                ForwardEndButtonView()
                Spacer()
            }
//MARK:- Layer
            SpeakerButtonView()
            //Maybe make a new struct view here
//            struct listView {
//                <#fields#>
//
        }.accentColor(.green)
//MARK:- Outside VStack
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
