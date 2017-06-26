//
//  WeatherForecastController.swift
//  OpenWeather
//
//  Created by Ujwal Manjunath on 6/25/17.
//  Copyright © 2017 Win-kel. All rights reserved.
//

import UIKit

class WeatherForecastController: UIViewController {
    
    var forecastList:[Forecast] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.registerCell(cellType: ForecastCell.self)
        fetchWeatherForecast()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func fetchWeatherForecast() {
        ApplicationContext.currentContext?.weatherManager?.fetchWeatherForecast(success: { (forecastList) in
            if let  list = forecastList as? [Forecast] {
                self.forecastList = list
            }
            
            self.collectionView.reloadData()
            
        }, failure: { (error) in
            print("Error: \(String(describing: error?.localizedDescription))")
        })
    }
}

extension WeatherForecastController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let forecastCell = collectionView.dequeue(cellType: ForecastCell.self, indexPath: indexPath)
        return forecastCell
    }
}

extension WeatherForecastController:UICollectionViewDelegate {
    
}
