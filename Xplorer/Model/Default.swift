//
//  Default.swift
//  Xplorer
//
//  Created by Joseph-Emmanuel Banzio on 27/03/2019.
//  Copyright © 2019 Joseph-Emmanuel Banzio. All rights reserved.
//

import Foundation

struct Defaults {
    
    static let (longitudeKey, latitudeKey) = ("longitude", "latitude")
    static let userSessionKey = "com.save.usersession"
    
    struct Model {
        var longitude: String?
        var latitude: String?
        
        init(_ json: [String: String]) {
            self.longitude  = json[longitudeKey]
            self.latitude   = json[latitudeKey]
        }
    }
    
    static var saveLongAndLat = { (longitude: String, latitude: String) in
        UserDefaults.standard.set([longitudeKey: longitude, latitudeKey: latitude], forKey: userSessionKey)
    }
    
    static var getLatAndLong = { _ -> Model in
        return Model((UserDefaults.standard.value(forKey: userSessionKey) as? [String: String]) ?? [:])
    }(())
    
    static func clearUserData(){
        UserDefaults.standard.removeObject(forKey: userSessionKey)
    }
}
