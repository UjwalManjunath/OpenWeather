//
//  Forecast.swift
//  OpenWeather
//
//  Created by Ujwal Manjunath on 6/26/17.
//  Copyright © 2017 Win-kel. All rights reserved.
//

import UIKit

class Forecast: NSObject {
    
    var date:Date?
    var dayTemperature:Float?
    var tempMax:Float?
    var tempMin:Float?
    
    override init() {
        super.init()
    }
    
    func updateWithDictionary(_ contentDictionary: [String : AnyObject]) {
        
        guard let newDate = contentDictionary["dt"] as? Date,
            let newTemp = contentDictionary["temp"] as? [String:AnyObject]
        else {
            return
        }
        
        guard let newDayTemp = newTemp["day"] as? Float,
            let newTempMax = newTemp["max"] as? Float,
            let newTempMin = newTemp["min"] as? Float
        else {
            return
        }
        
        date = newDate
        dayTemperature = newDayTemp
        tempMax = newTempMax
        tempMin = newTempMin
    }
    
}
