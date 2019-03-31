//
//  TableViewController.swift
//  Xplorer
//
//  Created by Joseph-Emmanuel Banzio on 25/03/2019.
//  Copyright © 2019 Joseph-Emmanuel Banzio. All rights reserved.
//

import UIKit
import CoreLocation

class WTableViewController: UITableViewController {
    
    var weathers = [Any]()
    var cities = ["Abidjan", "Paris", "New York", "Mexico", "Johannesburg", "Nice", "Lille", "Bruxelles", "Las Vegas", "Malaga", "Barcelone"]
    
    override func viewDidLoad() {
        addYourPosToCitiesArray()
        let latitude = UserDefaults.standard.value(forKey: "LAT") as! String
        let longitude = UserDefaults.standard.value(forKey: "LON") as! String
        
            DS_Service.weatherForCoord(latitude: latitude, longitude: longitude ) { (weather, error) in
                if let weatherData = weather {
                    let data = weatherData
                        self.weathers.append(data)
                        //print(self.weathers)
                        self.tableView?.reloadData()
                    }
                        
                    else if let _ = error {
                        print("Error with array initialization")
                    }
                }
       
        print(cities)
       
    }
        
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wCell", for: indexPath) as! WeatherCell
        //let cityName = cities[indexPath.row]
        
        if(weathers.count > 0){
           //let eachWeather = self.weathers[indexPath.row]
           cell.time.text = getCurrentHour()
        }
        cell.textLabel?.text = "toto"
        //cell.time.text = "00h58"
        
        return cell
    }
    
    /*
    func initArray(){
     convertCityNameToLatLong(address: cityName) { (coord, error) in
     DS_Service.weatherForCoord(latitude: String(coord.latitude), longitude: String(coord.longitude)) { (weather, error) in
     
     if let weatherData = weather {
     self.weathers.append(weatherData)
     //print(self.weathers)
     self.tableView?.reloadData()
     }
     
     else if let _ = error {
     print("Error with array initialization")
     }
     }
     }
        }
    }*/
    
    func getCurrentHour() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh"
        
        dateFormatter.dateFormat = "HH:mm"
        let currentDateString: String = dateFormatter.string(from: date)
        
        return currentDateString.uppercased()
    }
    
    /*
    func addYourPosToCitiesArray(){
        let latitude = UserDefaults.standard.value(forKey: "LAT_COOR")
        let longitude = UserDefaults.standard.value(forKey: "LON_COOR")
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            let locationName = placemarks?.first?.locality ?? "Unknown Location"
            self.cities.insert(locationName, at: 0)
        }
    }*/
    
    func convertCityNameToLatLong(address: String,
                                  completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }

}
