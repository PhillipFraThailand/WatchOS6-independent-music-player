//
//  DefaultSettings.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 9/30/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import Foundation
import APIClient

// Stores some values default settings like user id and tokens.

class DefaultSettings: Settings {
   var settings: [String: String] = [:]
    
   func value(forKey key: String) -> String? {
       return settings[key]
   }
   func setValue(_ value: String, forKey key: String) {
       settings[key] = value
   }
   func removeValue(forKey key: String) {
       settings.removeValue(forKey: key)
   }
}
