//
//  ForecastCell.swift
//  OpenWeather
//
//  Created by Ujwal Manjunath on 6/26/17.
//  Copyright © 2017 Win-kel. All rights reserved.
//

import UIKit

class ForecastCell: UICollectionViewCell {
    
    var forecast:Forecast? {
        didSet {
            updateUI()
        }
    }

    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI() {
        
        self.minLabel.text = forecast?.tempMinInFahrenheit()
        self.maxLabel.text = forecast?.tempMaxInFahrenheit()
        self.temperatureLabel.text = forecast?.temperatureInFahrenheit()
        self.dateLabel.text = forecast?.formattedDate()
    }

}
