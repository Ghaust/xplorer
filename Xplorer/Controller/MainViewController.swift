//
//  MainViewController.swift
//  Xplorer
//
//  Created by Joseph-Emmanuel Banzio on 25/03/2019.
//  Copyright © 2019 Joseph-Emmanuel Banzio. All rights reserved.
//

import UIKit
import CoreLocation

let defaults = UserDefaults.standard

class MainViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var currentCity: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var currentState: UILabel!
    @IBOutlet weak var currentStateIMG: UIImageView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var feelsLikeTemp: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var visibility: UILabel!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var greetingsText: UITextField!
    
    @IBOutlet weak var currentDay: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        //on récupère la location de l'utilisateur
        locationManager.requestLocation()
        
    }
    
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            //sauvegarde des données en cache
            UserDefaults.standard.set(String(location.coordinate.latitude), forKey: "LAT")
            UserDefaults.standard.set(String(location.coordinate.longitude), forKey: "LON")

            UserDefaults().synchronize()
            
            let latitude = UserDefaults.standard.value(forKey: "LAT")
            let longitude = UserDefaults.standard.value(forKey: "LON")
            
            DS_Service.weatherForCoord(latitude: latitude as! String, longitude: longitude as! String) { (weather, error) in
                
                if let weatherData = weather {
                    self.updateInfos(with: weatherData, at: location)  
                }
                
                else if let _ = error {
                    self.handleError(message: "Something is wrong with your location.")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print(error)
    }
    
    func updateInfos(with data: Weather, at location: CLLocation){
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            let locationName = placemarks?.first?.locality ?? "Unknown Location"
            self.currentCity.text = locationName
        }

        self.currentTemp.text = convertFarhenToCelsius(temp: data.temperature) + "°C"
        self.currentState.text = data.summary.uppercased()
        self.currentDate.text = data.convertUnixTime(timestamp: data.currentDate) as? String
        //print(data.convertUnixTime(timestamp: data.currentDate))
        self.currentStateIMG.image = UIImage(named: changeImageAccordingToCurrentWeather(with: data.icon))
        self.feelsLikeTemp.text = convertFarhenToCelsius(temp: data.feelsLikeTemp) + "°C"
        self.humidity.text = data.humidity + "%"
        self.wind.text = data.windSpeed + " Km/h"
        self.visibility.text = data.visibility + " Km"
        self.greetingsText.text = changeGreetings()
        self.currentDay.text = getCurrentDay()
    }

    func handleError(message: String) {
        let alert = UIAlertController(title: "Forecast Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
   
    
    func changeGreetings() -> String {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        let currentHour = Int(dateFormatter.string(from: date as Date))!
        
        if(currentHour < 12){
            return "MORNING"
            
        }
        if(currentHour < 17){
            return "AFTERNOON"
        }
        else if(currentHour < 21){
            return "EVENING"
        }
        else{
            return "NIGHT"
        }
    }

    func getCurrentDay() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        dateFormatter.dateFormat = "EEEE"
        let currentDateString: String = dateFormatter.string(from: date)
       
        return currentDateString.uppercased()
    }
    
   
}

func changeImageAccordingToCurrentWeather(with data: String) -> String {
    let rainy = "rainy"
    let smallCloudsInNight = "blue_cloudy"
    let smallCloudsInDay = "yellow_cloudy"
    let snowStormWithClouds = "snow"
    let stormcoming = "stormcoming"
    let snowstorm = "sunnyandverysnowy"
    let plentyOfCloudsInDay = "verycloudyyellow"
    let sunIsLife = "yellow_sun"
    let moonIsLifeToo = "blue_sun"
    let iLoveClouds = "partiallycloudyyellow"
    let image: String
    
    switch data {
    case "cloudy":
        image = iLoveClouds
    case "rain":
        image = rainy
    case "partly-cloudy-day":
        image =  smallCloudsInDay
    case "partly-cloudy-night":
        image =  smallCloudsInNight
    case "clear-day":
        image =  sunIsLife
    case "clear-night":
        image =  moonIsLifeToo
    case "snow":
        image =  snowstorm
    case "sleet":
        image =  snowStormWithClouds
    case "wind":
        image =  stormcoming
    case "fog":
        image =  plentyOfCloudsInDay
    default:
        image =  iLoveClouds
    }
    
    return image
}
