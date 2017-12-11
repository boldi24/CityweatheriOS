//
//  TodayViewController.swift
//  CityWeatherHomeExt
//
//  Created by Boldizsár Tömpe on 11/12/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import SDWebImage
import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
  
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var tempLabel: UILabel!
  private var cityName: String!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view from its nib.
    let name = UserDefaults(suiteName: "group.cityweather")!.string(forKey: "favCity")
    if let name = name {
      cityName = name
      WeatherDataInteractorImpl().getWeatherDataForCity(cityName: name, callback: self)
    } else {
      cityName = "Unknown"
    }
  }
  
  
  func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
    completionHandler(NCUpdateResult.newData)
  }
  
}

extension TodayViewController: GetWeatherDataForCityCallback {
  
  func getWeatherDataForCitySuccess(weatherData: CloudWeatherData) {
    cityLabel.text = cityName
    if let temp = weatherData.main?.temp {
      tempLabel.text = String(format:"%.0f", temp) + " °C"
    }
    iconImageView.sd_setImage(with: URL(string: "http://openweathermap.org/img/w/" + (weatherData.weather?[0].icon ?? "") + ".png"), placeholderImage: UIImage(named: "error"))
  }
  
  func getWeatherDataForCityError() {
    
  }
  

}
