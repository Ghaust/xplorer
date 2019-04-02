//
//  TableViewController.swift
//  Xplorer
//
//  Created by Joseph-Emmanuel Banzio on 25/03/2019.
//  Copyright © 2019 Joseph-Emmanuel Banzio. All rights reserved.
//

import UIKit
import CoreLocation

class WTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var weathers = [WeatherData]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        let latitude = UserDefaults.standard.value(forKey: "LAT_NS")
        let longitude = UserDefaults.standard.value(forKey: "LON_NS")
        //ville par défaut
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude as! CLLocationDegrees, longitude: longitude as! CLLocationDegrees )) { (placemarks:[CLPlacemark]?, error:Error?) in
            
            if let city = placemarks?.first?.locality {
                self.updateInfos(cityName: city)
            }
            
        }
        
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let cityName = searchBar.text, !cityName.isEmpty {
            updateInfos(cityName: cityName)
        }
        
    }
    
    func updateInfos(cityName: String){
        //on utilise CLGeocoder pour obtenir des coordonnées géographiques à partir d'une adresse
        CLGeocoder().geocodeAddressString(cityName){ (placemarks:[CLPlacemark]?, error:Error?) in
            
            if error == nil {
                if let location = placemarks?.first?.location{
                    WeatherData.forecast(withLocation: location.coordinate, completion: { (res:[WeatherData]?) in
                        
                        if let wData = res {
                            self.weathers = wData
                            
                            //permet de sauvegarder les données dans une fonction asynchrone
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            
                        }
                    })
                }
                
            }
            
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return weathers.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
  
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let currentDate = Calendar.current.date(byAdding: .day, value: section, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        return dateFormatter.string(from: currentDate!)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wCell", for: indexPath)
       let weatherData = weathers[indexPath.section]
        
        cell.textLabel?.text = weatherData.summary
        let temp = convertFarhenToCelsius(temp: String(weatherData.temperature))
        cell.detailTextLabel?.text = "\(temp) °C"
        cell.imageView?.image = UIImage(named: changeImageAccordingToCurrentWeather(with: weatherData.icon))
        return cell
    }
    
    
    func getCurrentHour() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh"
        
        dateFormatter.dateFormat = "HH:mm"
        let currentDateString: String = dateFormatter.string(from: date)
        
        return currentDateString.uppercased()
    }
    

}
