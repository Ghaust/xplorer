//
//  TopArtist.swift
//  Xplorer
//
//  Created by Joseph-Emmanuel Banzio on 11/03/2019.
//  Copyright © 2019 Joseph-Emmanuel Banzio. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
import ObjectMapper

class WorldTime : NSObject, Mappable {
    
    var weekNumber, utcOffset, unixtime, timezone, dstUntil, dstFrom, datetime, abbreviation: String?
    var dst: Bool?
    var dayOfYear, dayOfWeek: Int?
   
    override init(){
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        weekNumber <- map["week_number"]
        datetime <- map["datetime"]
        dstUntil <- map["dst_until"]
        dstFrom <- map["dst_from"]
        utcOffset <- map["utc_offset"]
        timezone <- map["timezone"]
        dst <- map["dst"]
        abbreviation <- map["abbreviation"]
        dayOfWeek <- map["day_of_week"]
        dayOfYear <- map["day_of_year"]
        unixtime <- map["unixtime"]
    }
    
}
