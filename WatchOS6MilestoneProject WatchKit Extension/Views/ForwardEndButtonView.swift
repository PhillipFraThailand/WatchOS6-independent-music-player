//
//  ForwardEndButtonView.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 10/17/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import SwiftUI

struct ForwardEndButtonView: View {
    var body: some View {
        Button(action: PlaybackService.sharedInstance.playerSkipForward) {
            Image(systemName: "forward.end")
        }
    }
}

struct ForwardEndButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ForwardEndButtonView()
    }
}
