//
//  trackModel.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 10/12/2019.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import Foundation
struct TrackModel: Identifiable {
    public static let serviceEntityType = "application/json"

      /* public let links: [String]
       public let linkTemplates: [String]? */
       public let name: String
       public let artistName: String
       public let albumName: String
       public let lengthInSeconds: Int
       public let genre: String
       public let label: String
       public let releaseDate: String
       public let id: Int
       public let availableInSubscription: Bool
       public let isrc: String
       public let popularity: Float
}
