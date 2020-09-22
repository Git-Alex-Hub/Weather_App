//
//  WeatherTableViewCell.swift
//  Homework 24 Peniaz
//
//  Created by MacOS on 25.08.2020.
//  Copyright © 2020 MacOS. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
