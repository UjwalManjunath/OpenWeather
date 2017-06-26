//
//  WeatherController.swift
//  OpenWeather
//
//  Created by Ujwal Manjunath on 6/25/17.
//  Copyright © 2017 Win-kel. All rights reserved.
//

import UIKit

class WeatherController: UIViewController {

    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var weather:Weather?
    
    var isFetching:Bool = false {
        didSet {
            UIView.animate(withDuration: 0.25) { 
                if self.isFetching  {
                    self.loadingView.alpha = 1.0
                } else {
                    self.loadingView.alpha = 0.0
                }
            }
        }
    }
    
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
        
        isFetching = true
        ApplicationContext.currentContext?.weatherManager?.fetchCurrentWeather(success: { (weather) in
            
            self.weather = weather as? Weather
            
            self.updateUI()
            self.isFetching = false
        }, failure: { (error) in
            print("Error: \(String(describing: error?.localizedDescription))")
            self.isFetching = false
        })
    }
    
    func updateUI() {
        
        guard  let weather = self.weather else {
            return
        }
        
        self.descriptionLabel.text = weather.weatherDescription?.capitalized
        
        self.temperatureLabel.text = weather.temperatureInFahrenheit()
        self.tempMaxLabel.text = "High : " + weather.tempMaxInFahrenheit()
        self.tempMinLabel.text = " Low : " + weather.tempMinInFahrenheit()
        
        self.pressureLabel.text = "Pressure : \(weather.pressure!) hPa"
        self.humidityLabel.text = "Humidity : \(weather.humidity!)%"
    }

    @IBAction func didTapOnShareButton(_ sender: UIBarButtonItem) {
        
        guard  let weather = self.weather else {
            return
        }
        
        let description = "Description :" + weather.weatherDescription!.capitalized
        let temperature = "Temperature : " + weather.temperatureInFahrenheit()
        let tempMax = "High : " + weather.tempMaxInFahrenheit()
        let tempMin = "Low : " + weather.tempMaxInFahrenheit()
        
        let pressure = "Pressure : \(weather.pressure!) hPa"
        let humidity = "Humidity : \(weather.humidity!)%"
        
        let controller = UIActivityViewController(activityItems: [description, temperature, tempMax, tempMin, pressure, humidity], applicationActivities: nil)
        controller.popoverPresentationController?.sourceView = self.view
        controller.excludedActivityTypes = [.assignToContact, .addToReadingList, .openInIBooks, .print]
        self.present(controller, animated: true, completion: nil)

    }
}
