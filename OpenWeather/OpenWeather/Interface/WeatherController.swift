//
//  WeatherController.swift
//  OpenWeather
//
//  Created by Ujwal Manjunath on 6/25/17.
//  Copyright © 2017 Win-kel. All rights reserved.
//

import UIKit

class WeatherController: UIViewController {

    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var weather:Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchCurrentWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchCurrentWeather() {
        
        ApplicationContext.currentContext?.weatherManager?.fetchCurrentWeather(success: { (weather) in
            
            self.weather = weather as? Weather
            
            self.updateUI()
            
        }, failure: { (error) in
            print("Error: \(String(describing: error?.localizedDescription))")
        })
    }
    
    func updateUI() {
        
        guard  let weather = self.weather else {
            return
        }
        self.descriptionLabel.text = weather.weatherDescription
        self.temperatureLabel.text = "\(String(describing: weather.temperature))"
        self.tempMaxLabel.text = "\(String(describing: weather.tempMax))"
        self.tempMinLabel.text = "\(String(describing: weather.tempMin))"
        
        self.pressureLabel.text = "\(String(describing: weather.pressure))"
        self.humidityLabel.text = "\(String(describing: weather.humidity))"
    }

}
