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
        
        guard let newDate = contentDictionary["dt"] as? TimeInterval,
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
        
        date = Date(timeIntervalSince1970: newDate)
        dayTemperature = newDayTemp
        tempMax = newTempMax
        tempMin = newTempMin
    }
    
    func formattedDate() -> String {
        if let dateString = DateFormatter.FormattedStringFromDate(date: self.date!) {
            return dateString
        }
        return ""
    }
    
    func temperatureInFahrenheit() -> String {
        return "\(convertToFahrenheit(tempInKelvin: dayTemperature!))"
    }
    
    func tempMaxInFahrenheit() -> String {
        return "\(convertToFahrenheit(tempInKelvin: tempMax!))"
    }
    
    func tempMinInFahrenheit() -> String {
        return "\(convertToFahrenheit(tempInKelvin: tempMin!))"
    }
    
    func convertToFahrenheit(tempInKelvin:Float) -> Float {
        return tempInKelvin * (9.0/5.0) - 459.67
    }
}
