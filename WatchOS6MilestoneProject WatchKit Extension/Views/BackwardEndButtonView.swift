//
//  BackwardEndButtonView.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 10/17/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import SwiftUI

struct BackwardEndButtonView: View {
    var body: some View {
        Button(action: PlaybackService.sharedInstance.playerskipBackward) {
            Image(systemName: "backward.end")
        }
    }
}

struct BackwardEndButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackwardEndButtonView()
    }
}
