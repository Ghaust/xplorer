//
//  MainViewController.swift
//  Xplorer
//
//  Created by Joseph-Emmanuel Banzio on 25/03/2019.
//  Copyright © 2019 Joseph-Emmanuel Banzio. All rights reserved.
//

import UIKit
import CoreLocation

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
    @IBOutlet weak var cityWanted: UISearchBar!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var greetingsText: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        DS_Service.weatherForCoord(latitude: "50", longitude: "122"){ (response, error) in
            print("\(response)")
            print("\(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        //on récupère la location de l'utilisateur
        locationManager.requestLocation()
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            
            DS_Service.weatherForCoord(latitude: latitude, longitude: longitude) { (weather, error) in
                
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

        self.currentTemp.text = data.convertFarhenToCelsius(temp: data.temperature) + "°C"
        self.currentState.text = data.summary.uppercased()
        self.currentDate.text = data.currentDate
        self.currentStateIMG = self.change(with: data)
        //self.currentStateIMG.text = data.icon
        self.feelsLikeTemp.text =  data.convertFarhenToCelsius(temp:data.feelsLikeTemp) + "°C"
        self.humidity.text = data.humidity + "%"
        self.wind.text = data.windSpeed + " Km/h"
        self.visibility.text = data.visibility + " Km"
    }

    func handleError(message: String) {
        let alert = UIAlertController(title: "Forecast Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func change(with data: Weather) -> UIImageView {
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
        let image: UIImage
        let imageView: UIImageView
        
        switch data.icon {
        case "cloudy":
            image = UIImage(named: iLoveClouds)!
            imageView = UIImageView(image: image)
        case "rain":
            image = UIImage(named: rainy)!
            imageView = UIImageView(image: image)
        case "partly-cloudy-day":
            image = UIImage(named: smallCloudsInDay)!
            imageView = UIImageView(image: image)
        case "partly-cloudy-night":
            image = UIImage(named: smallCloudsInNight)!
            imageView = UIImageView(image: image)
        case "clear-day":
            image = UIImage(named: sunIsLife)!
            imageView = UIImageView(image: image)
        case "clear-night":
            image = UIImage(named: moonIsLifeToo)!
            imageView = UIImageView(image: image)
        case "snow":
            image = UIImage(named: snowstorm)!
            imageView = UIImageView(image: image)
        case "sleet":
            image = UIImage(named: snowStormWithClouds)!
            imageView = UIImageView(image: image)
        case "wind":
            image = UIImage(named: stormcoming)!
            imageView = UIImageView(image: image)
        case "fog":
            image = UIImage(named: plentyOfCloudsInDay)!
            imageView = UIImageView(image: image)
        default:
            image = UIImage(named: iLoveClouds)!
            imageView = UIImageView(image: image)
        }
        
        return imageView
    }


}
