//
//  WeatherTableViewCell.swift
//  RainyShinyCloud
//
//  Created by Ahmad Ayman on 8/25/17.
//  Copyright © 2017 Ahmad Ayman. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var weatherTemLabel: UILabel!
    @IBOutlet weak var wetherFerLabel: UILabel!

    @IBOutlet weak var cloudyLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
