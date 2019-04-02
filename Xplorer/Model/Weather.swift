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
import SwiftyJSON

struct Weather {
    var temperature: String
    var summary: String
    var icon: String
    var windSpeed: String
    var humidity: String
    var feelsLikeTemp: String
    var visibility: String
    var currentDate: String
    
    init(data: Any) {
        let json = JSON(data)
        let currentW = json["currently"]
        
        if let temp = currentW["temperature"].float {
            self.temperature = String(format: "%0.f", temp)
            
        }else{
            self.temperature = "-"
        }
        
        if let wind = currentW["windSpeed"].float {
           self.windSpeed = String(wind)
            
        }else{
            self.windSpeed = "-"
        }
        
        if let hum = currentW["humidity"].float {
            self.humidity = String(hum)
            
        }else{
            self.humidity = "-"
        }
        
        if let vis = currentW["visibility"].float {
            self.visibility = String(vis)
            
        }else{
            self.visibility = "-"
        }
        
      
        if let fLTemp = currentW["apparentTemperature"].float {
            self.feelsLikeTemp = String(fLTemp)
        }else{
            self.feelsLikeTemp = "-"
        }

        if let timestamp = currentW["time"].int {
             self.currentDate = String(timestamp)
        }else{
            self.currentDate = "-"
        }
        
        self.summary = currentW["summary"].string ?? "-"
        self.icon = currentW["icon"].string ?? "-"
       
    }
    
    
    func convertUnixTime(timestamp: String) -> Any {
        let date = Date(timeIntervalSince1970: Double(timestamp)!)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let strDate = dateFormatter.string(from: date)
        return strDate
        
    }

}

func convertFarhenToCelsius(temp: String) -> String {
    if temp.isEmpty {
        return "-"
    }else{
        return String(Int(5.0/9.0 * ((Double(temp)!) - 32.0)))
        
    }
}
