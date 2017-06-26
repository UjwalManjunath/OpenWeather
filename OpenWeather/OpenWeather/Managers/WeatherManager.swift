//
//  WeatherManager.swift
//  OpenWeather
//
//  Created by Ujwal Manjunath on 6/25/17.
//  Copyright © 2017 Win-kel. All rights reserved.
//

import UIKit

class WeatherManager: NSObject {
    
    let apiKey:String = "a761e33f55472adc699fdaafb87c4dd8"
    
    private var serviceManager:ServiceManager?
    
    public init(serviceManager:ServiceManager) {
        super.init()
        self.serviceManager = serviceManager
    }

    //	Retrieve the current weather – “/weather?q=Mumbai,IN&APPID=APIKEY”
    func fetchCurrentWeather(success:@escaping FetchSuccess, failure:@escaping FetchFailure) {
        
        let parameters:[String:AnyObject] = [
            "q":"Mumbai,IN" as AnyObject,
            "appid":apiKey as AnyObject
        ]
        
        let path = "weather"
        
        self.serviceManager?.processRequest(path: path, parameters: parameters, completion: { (responseJSON) in
            
            let current = Weather()

            if let json = responseJSON as? [String:AnyObject] {
                current.updateWithDictionary(json)
            }
            
            success(current as AnyObject)

        }, failure: failure)
    }
    
    //	Retrieve the forecast for Mumbai – “/forecast/daily?q= Mumbai,IN&cnt=7&appid=APIKEY”
    func fetchWeatherForecast(success:@escaping FetchSuccess, failure:@escaping FetchFailure) {
        
        let parameters:[String:AnyObject] = [
            "q":"Mumbai,IN" as AnyObject,
            "cnt":7 as AnyObject,
            "appid":"a761e33f55472adc699fdaafb87c4dd8" as AnyObject
        ]
        
        let path = "forecast/daily"
        
        self.serviceManager?.processRequest(path: path, parameters: parameters, completion: { (responseJSON) in
            
            var weatherForecast:[Forecast] = []
            if let json = responseJSON as? [String:AnyObject] {
                if let lists = json["list"] as? [[String:AnyObject]] {
                    
                    for list in lists {
                        let forecast = Forecast()
                        forecast.updateWithDictionary(list)
                        weatherForecast.append(forecast)
                    }
                }
            }
            
            success(weatherForecast as AnyObject)

        }, failure: failure)
    }

}
