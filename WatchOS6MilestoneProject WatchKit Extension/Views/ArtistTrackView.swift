//
//  ArtistTrackView.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 10/17/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import SwiftUI

struct ArtistTrackView: View {
    
    @ObservedObject var TP = TracklistProvider.sharedInstance
    
    var body: some View {
        return VStack {
            Text(verbatim: TP.artistName ?? "Artist")
            Text(verbatim: TP.trackName ?? "Track")
        }
    }
}

struct ArtistTrackView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistTrackView()
    }
}
