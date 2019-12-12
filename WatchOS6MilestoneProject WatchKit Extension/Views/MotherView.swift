//
//  MotherView.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 10/8/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import Foundation
import SwiftUI

struct MotherView: View {
    
   @ObservedObject var tracklistProvider: TracklistProvider
    
    var body: some View {
    VStack {
        if TracklistProvider.sharedInstance.isLoading == true {
            LoadingView()
        } else if TracklistProvider.sharedInstance.isLoading == false {
            PlayerView()
            }
        }
    }
}

#if DEBUG
struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(tracklistProvider: TracklistProvider.sharedInstance)
       
    }
}

struct PlayerView_Previews1: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}

struct LoadingView_Previws1: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

#endif
