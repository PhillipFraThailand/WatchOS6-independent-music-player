//
//  HostinController1.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 06/12/2019.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import Foundation
import WatchKit
import SwiftUI

class HostingController1: WKHostingController<ListView> {
    override var body: ListView {
        return ListView(model: PlaybackService.sharedInstance)
    }
}
