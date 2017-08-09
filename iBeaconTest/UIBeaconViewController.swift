//
//  UIBeaconViewController.swift
//  iBeaconTest
//
//  Created by Cristi Sava on 08/08/2017.
//  Copyright © 2017 Cristi Sava. All rights reserved.
//

import UIKit

class UIBeaconViewController: UIViewController, ESTBeaconManagerDelegate {
    
    // MARK: - Props
    
    let region = CLBeaconRegion(
        proximityUUID: UUID(uuidString: BeaconsUUID)!,
        major: BeaconsMajorID, identifier: RegionIdentifier)
    
    let colors: [MyBeacon : UIColor] =
        [MyBeacon.pink: UIColor(red: 240/255.0, green: 183/255.0, blue: 183/255.0, alpha: 1),
         MyBeacon.magenta : UIColor(red: 149/255.0, green: 70/255.0, blue: 91/255.0, alpha: 1),
         MyBeacon.yellow : UIColor(red: 251/255.0, green: 254/255.0, blue: 53/255.0, alpha: 1)]
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var label: UILabel!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetBackgroundColor()
        setupBeaconManager()
    }
    
    // MARK: - UI Utilities
    
    func resetBackgroundColor() {
        self.view.backgroundColor = UIColor.green
    }
    
    // MARK: - ESTBeaconManagerDelegate - Utilities
    
    func setupBeaconManager() {
        BeaconManager.main.delegate = self
        
        if (BeaconManager.main.isAuthorizedForMonitoring() && BeaconManager.main.isAuthorizedForRanging()) == false {
            BeaconManager.main.requestAlwaysAuthorization()
        }
    }
    
    func startMonitoring() {
        
        BeaconManager.main.startMonitoring(for: region)
        BeaconManager.main.startRangingBeacons(in: region)
    }
    
    // MARK: - ESTBeaconManagerDelegate
    
    func beaconManager(_ manager: Any, didChange status: CLAuthorizationStatus) {
        
        if status == .authorizedAlways ||
            status == .authorizedWhenInUse {
            startMonitoring()
        }
    }
    
    func beaconManager(_ manager: Any, monitoringDidFailFor region: CLBeaconRegion?, withError error: Error) {
        label.text = "FAIL " + (region?.proximityUUID.uuidString)!
    }
    
    func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
        
        label.text = "Hello beacons from \(region.identifier)"
    }
    
    func beaconManager(_ manager: Any, didExitRegion region: CLBeaconRegion) {
        
        label.text = "Bye bye beacons from \(region.identifier)"
    }
    
    func beaconManager(_ manager: Any, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        let knownBeacons = beacons.filter { (beacon) -> Bool in
            
            return beacon.proximity != CLProximity.unknown
        }
        
        if let firstBeacon = knownBeacons.first,
            let myBeacon = MyBeacon(rawValue:firstBeacon.minor.stringValue)   {
            
            let beaconColor = colors[myBeacon]
            self.view.backgroundColor = beaconColor
        }
        else {
            resetBackgroundColor()
        }
    }
    
    func beaconManager(_ manager: Any, didFailWithError error: Error) {
        label.text = "DID FAIL WITH ERROR" + error.localizedDescription
    }
}

