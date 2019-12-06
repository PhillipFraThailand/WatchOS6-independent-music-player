//
//  HostingController.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 9/11/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

// The hosting controller takes in a 'rootView' that we have set as Motherview.

class HostingController: WKHostingController<MotherView> {
    override var body: MotherView {
        return MotherView(tracklistProvider: TracklistProvider.sharedInstance)
    }
}
