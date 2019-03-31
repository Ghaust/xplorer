//
//  Default.swift
//  Xplorer
//
//  Created by Joseph-Emmanuel Banzio on 27/03/2019.
//  Copyright © 2019 Joseph-Emmanuel Banzio. All rights reserved.
//

import Foundation
import CoreLocation

extension UserDefaults {
    
    func set(location:CLLocation, key: String){
        let locationLat = NSNumber(value:location.coordinate.latitude)
        let locationLon = NSNumber(value:location.coordinate.longitude)
        self.set(["lat": locationLat, "lon": locationLon], forKey:key)
    }
    
    func location(forKey key: String) -> CLLocation?
    {
        if let locationDictionary = self.object(forKey: key) as? Dictionary<String,NSNumber> {
            let locationLat = locationDictionary["lat"]!.doubleValue
            let locationLon = locationDictionary["lon"]!.doubleValue
            return CLLocation(latitude: locationLat, longitude: locationLon)
        }
        return nil
    }
}
