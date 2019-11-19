//
//  DefaultConfiguration.swift
//  WatchOS6MilestoneProject WatchKit Extension
//
//  Created by Phillip Eismark on 9/30/19.
//  Copyright © 2019 Phillip Eismark. All rights reserved.
//

import Foundation
import APIClient

public struct DefaultConfiguration : Configuration {
    //portal: yousee,telmore,juke
    public var portalId = "1458"
    public var portalUrl = "http://yousee.api.247e.com" // Make URL?
    public let clientKey : String? = "MjQ3LW11c2ljYXBwLWlvcy15b3VzZWU6Z3ZhdjJZOVFXd2NOd0NmODN0NHJ0UVc4eWlnTnFLTGY=" //req when auth
    public let portalTokenLinkRel: String? = "yousee:token" //only req for yousee (only one who has a differnet portal token link)
    
}
