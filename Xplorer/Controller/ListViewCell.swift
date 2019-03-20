//
//  FormViewController.swift
//  Xplorer
//
//  Created by Joseph-Emmanuel Banzio on 08/02/2019.
//  Copyright © 2019 Joseph-Emmanuel Banzio. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel?
    @IBOutlet weak var currentTime: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initizialize code here
    }
    
    override func setSelected(_ selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)
    }
}
