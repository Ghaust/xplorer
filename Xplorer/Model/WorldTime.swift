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



class WorldTime {
    let weekNumber, utcOffset, unixtime, timezone: String
    let dstUntil, dstFrom: String
    let dst: Bool
    let dayOfYear, dayOfWeek: Int
    let datetime, abbreviation: String
    
   
    init(weekNumber: String, utcOffset: String, unixtime: String, timezone: String, dstUntil: String, dstFrom: String, dst: Bool, dayOfYear: Int, dayOfWeek: Int, datetime: String, abbreviation: String) {
        self.weekNumber = weekNumber
        self.utcOffset = utcOffset
        self.unixtime = unixtime
        self.timezone = timezone
        self.dstUntil = dstUntil
        self.dstFrom = dstFrom
        self.dst = dst
        self.dayOfYear = dayOfYear
        self.dayOfWeek = dayOfWeek
        self.datetime = datetime
        self.abbreviation = abbreviation
    }
}
