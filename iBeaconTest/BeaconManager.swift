//
//  BeaconManager.swift
//  iBeaconTest
//
//  Created by Cristi Sava on 08/08/2017.
//  Copyright © 2017 Cristi Sava. All rights reserved.
//

import UIKit

enum MyBeacon: String {
    
    case pink = "4045"
    case magenta = "20372"
    case yellow = "22270"
}

let BeaconsUUID: String = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
let RegionIdentifier: String  = "IntelligentBee Office"
let BeaconsMajorID: UInt16  = 11111

class BeaconManager: ESTBeaconManager {

    static let main : BeaconManager = BeaconManager()
    
}
