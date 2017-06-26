//
//  Weather.swift
//  OpenWeather
//
//  Created by Ujwal Manjunath on 6/26/17.
//  Copyright © 2017 Win-kel. All rights reserved.
//

import UIKit

class Weather: NSObject {
    
    var weatherDescription:String?
    var temperature:Float?
    var pressure:Float?
    var humidity:Float?
    var tempMax:Float?
    var tempMin:Float?
    
    override init() {
        super.init()
    }
    
    func updateWithDictionary(_ contentDictionary: [String : AnyObject]) {
        
        guard let newWeather = contentDictionary["weather"] as? [[String:AnyObject]],
            let main = contentDictionary["main"] as? [String:AnyObject]
        else {
            return
        }
        
        guard let newWeatherDescription = newWeather.first?["description"] as? String,
            let newTemp = main["temp"] as? Float,
            let newPressure = main["pressure"] as? Float,
            let newHumidity = main["humidity"] as? Float,
            let newTempMax = main["temp_max"] as? Float,
            let newTempMin = main["temp_min"] as? Float
        else {
            return
        }
        
        weatherDescription = newWeatherDescription
        temperature = newTemp
        pressure = newPressure
        humidity = newHumidity
        tempMax = newTempMax
        tempMin = newTempMin
    }
    
    func temperatureInFahrenheit() -> String {
        return "\(convertToFahrenheit(tempInKelvin: temperature!))" + "\u{00B0}"
    }
    
    func tempMaxInFahrenheit() -> String {
        return "\(convertToFahrenheit(tempInKelvin: tempMax!))" + "\u{00B0}"
    }
    
    func tempMinInFahrenheit() -> String {
        return "\(convertToFahrenheit(tempInKelvin: tempMin!))" + "\u{00B0}"
    }
    
    func convertToFahrenheit(tempInKelvin:Float) -> Int {
        let F = tempInKelvin * (9.0/5.0) - 459.67
        return Int(F)
    }
}
