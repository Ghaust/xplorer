//
//  DarkSyService.swift
//  Xplorer
//
//  Created by Joseph-Emmanuel Banzio on 25/03/2019.
//  Copyright © 2019 Joseph-Emmanuel Banzio. All rights reserved.
//

import Foundation
import Alamofire

class DS_Service {
    private static let url = "https://api.darksky.net/forecast/"
    private static let api_key = "3acf126226f53c64b49e1927df2848a7"
    
    //fonction qui retourne un objet de type Weather en fonction des coordonnées géographiques envoyées
    static func weatherForCoord(latitude: String, longitude: String, completion: @escaping (Weather?, Error?) -> ()) {
        
        let req_url = url + api_key + "/\(latitude),\(longitude)"
        
        Alamofire.request(req_url).responseJSON { (response) in
            switch response.result {
                case .success(let result):
                    completion(Weather(data: result), nil)
                case .failure(let error):
                    completion(nil, error)
            }
        }
    }
}
