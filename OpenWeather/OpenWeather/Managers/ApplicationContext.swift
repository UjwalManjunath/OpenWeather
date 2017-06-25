//
//  ApplicationContext.swift
//  OpenWeather
//
//  Created by Ujwal Manjunath on 6/26/17.
//  Copyright © 2017 Win-kel. All rights reserved.
//

import UIKit

class ApplicationContext: NSObject {
    
    static var currentContext:ApplicationContext?

    var weatherManager:WeatherManager?
    var serviceManager:ServiceManager?
    
    override init() {
        
    }

}
