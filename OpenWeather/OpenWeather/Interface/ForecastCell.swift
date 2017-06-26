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
            if forecast != nil {
                updateUI()
            }
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
        
        self.minLabel.text = "High : " + forecast!.tempMinInFahrenheit() + "\u{00B0}"
        self.maxLabel.text = " Low : " + forecast!.tempMaxInFahrenheit() + "\u{00B0}"
        self.temperatureLabel.text = forecast!.temperatureInFahrenheit() + "\u{00B0}"
        self.dateLabel.text = forecast!.formattedDate()
    }

}
