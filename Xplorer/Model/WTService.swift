//
//  WTService.swift
//  Xplorer
//
//  Created by Joseph-Emmanuel Banzio on 20/03/2019.
//  Copyright © 2019 Joseph-Emmanuel Banzio. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

/*if let variable = responseValue?.dayOfYear {
 print("La variable déballée vaut \(variable)")
 }afficher des valeurs optionnels*/

class WTService {
    let worldtimeURL = "http://worldtimeapi.org/api/timezone/Europe/" //on rajoute la ville voulue
    var cities = ["Amsterdam","Andorra","Astrakhan","Athens","Belgrade","Berlin","Brussels","Bucharest","Budapest","Chisinau","Copenhagen","Dublin","Gibraltar","Helsinki","Istanbul","Kaliningrad","Kiev","Kirov","Lisbon","London","Luxembourg","Madrid","Malta","Minsk","Monaco","Moscow","Oslo","Paris","Prague","Riga","Rome","Samara","Saratov","Simferopol","Sofia","Stockholm","Tallinn","Zurich"]
    var database = [WorldTime]()
    
    func storeDataInDB(){
        for i in 0 ..< cities.count {
            //A chaque tour de boucle, on fait une GET requête sur l'url + une ville et on la stocke dans database
            Alamofire.request(worldtimeURL+cities[i]).responseObject { (response: DataResponse<WorldTime>) in
                
                if let responseValue = response.result.value {
                    self.database.append(responseValue)
                }
                
                
            }
        }
    }
}
