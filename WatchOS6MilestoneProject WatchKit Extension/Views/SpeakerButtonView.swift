//
//  SpeakerButtonView.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 10/17/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import SwiftUI

struct SpeakerButtonView: View {
    var body: some View {
       Button(action: PlaybackService.sharedInstance.speakerButton) {
            Image(systemName:"speaker.2")
        }
        
    }
}

struct SpeakerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SpeakerButtonView()
    }
}
