//
//  ListView.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 05/12/2019.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var model: PlaybackService
    
    var body: some View {
        List() {
            ForEach(model.trackModels) { trackmodel in
                VStack {
                    Text(trackmodel.artistName + ": " + trackmodel.name).onTapGesture {
                        //Hvordan feedr jeg audioplayer : feed her ud fra id nr.
                        // På id
                        //Manipuler med begge model arrays
                        //Kald så tracklistprovider med trackpreview
                    }
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(model: PlaybackService.sharedInstance)
    }
} 
