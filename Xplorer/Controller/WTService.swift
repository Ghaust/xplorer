//
//  ForecastTopArtistService.swift
//  Xplorer
//
//  Created by Joseph-Emmanuel Banzio on 12/03/2019.
//  Copyright © 2019 Joseph-Emmanuel Banzio. All rights reserved.
//

import Foundation
import Alamofire

class WTService{
    
    let worldtimeURL = URL(string:"http://worldtimeapi.org/api/timezone/") //on rajoute la ville voulue
    
    var cities = ["Amsterdam","Andorra","Astrakhan","Athens","Belgrade","Berlin","Brussels","Bucharest","Budapest","Chisinau","Copenhagen","Dublin","Gibraltar","Helsinki","Istanbul","Kaliningrad","Kiev","Kirov","Lisbon","London","Luxembourg","Madrid","Malta","Minsk","Monaco","Moscow","Oslo","Paris","Prague","Riga","Rome","Samara","Saratov","Simferopol","Sofia","Stockholm","Tallinn","Zurich"]
    
    var database = [WorldTime]()
    
    func storeCurrentTimeFromAPI(url: String){
        
        for i in 0...cities.count {
            //A chaque tour de boucle, on fait une GET requête sur l'url + une ville
            AF.request(url+cities[i]).responseJSON { response in
                
                if let responseValue = response.result.value as! [String: Any]? {
                    print("JSON: \(responseValue)")
                    
                }
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8){
                    print("Data: \(utf8Text)")
                }
            }
        }
        
        
    }

    
}
