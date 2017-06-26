//
//  WeatherForecastController.swift
//  OpenWeather
//
//  Created by Ujwal Manjunath on 6/25/17.
//  Copyright © 2017 Win-kel. All rights reserved.
//

import UIKit

class WeatherForecastController: UIViewController {
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    var forecastList:[Forecast] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    var isFetching:Bool = false {
        didSet {
            UIView.animate(withDuration: 0.25) {
                if self.isFetching  {
                    self.collectionView.alpha = 0.0
                } else {
                    self.collectionView.alpha = 1.0
                }
            }
        }
    }
    
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
        self.isFetching = true
        ApplicationContext.currentContext?.weatherManager?.fetchWeatherForecast(success: { (forecastList) in
            
            if let  list = forecastList as? [Forecast] {
                self.forecastList = list
            }
            
            self.collectionView.reloadData()
            self.isFetching = false
            
        }, failure: { (error) in
            print("Error: \(String(describing: error?.localizedDescription))")
            self.isFetching = false
        })
    }
}

extension WeatherForecastController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let forecastCell = collectionView.dequeue(cellType: ForecastCell.self, indexPath: indexPath)
        forecastCell.forecast = self.forecastList[indexPath.row]
        return forecastCell
    }
}

extension WeatherForecastController:UICollectionViewDelegate {
    
}

extension WeatherForecastController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    
}
