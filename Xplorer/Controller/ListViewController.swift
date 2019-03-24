//
//  ListViewController.swift
//  Xplorer
//
//  Created by Joseph-Emmanuel Banzio on 20/03/2019.
//  Copyright © 2019 Joseph-Emmanuel Banzio. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let worldtimeURL = "http://worldtimeapi.org/api/timezone/Europe/" //on rajoute la ville voulue
    var cities = ["Amsterdam","Andorra","Astrakhan","Athens","Belgrade","Berlin","Brussels","Bucharest","Budapest","Chisinau","Copenhagen","Dublin","Gibraltar","Helsinki","Istanbul","Kaliningrad","Kiev","Kirov","Lisbon","London","Luxembourg","Madrid","Malta","Minsk","Monaco","Moscow","Oslo","Paris","Prague","Riga","Rome","Samara","Saratov","Simferopol","Sofia","Stockholm","Tallinn","Zurich"]
    var database: [String: Any] = [String: Any]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        storeDataInDB()
       //print(cities.count)
       //print(database)
        
        
    }
    
    func getCity(cityName: String) {
        
    }
    
    func storeDataInDB(){
        var i = 0
        //var unwrapped: WorldTime?
        for cityName in cities{
            //database[city] = getCity(cityName: self.cities[i])
            Alamofire.request(worldtimeURL+cityName).responseJSON { (response) in
                if let responseValue = response.result.value as! [String: Any]? {
                    self.database[cityName] = responseValue
                    self.tableView?.reloadData()
                }
            }
            i+=1
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell") as! ListViewCell
        
        if self.database.count > 0 {
            let eachTime = self.database[indexPath.row]
            cell.
        }
        return cell
    }
    
}
