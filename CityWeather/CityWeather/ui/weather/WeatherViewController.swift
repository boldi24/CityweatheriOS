//
//  WeatherViewController.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 18/11/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import SDWebImage
import SVProgressHUD
import UIKit

class WeatherViewController: UIViewController {
  
  private var weatherInteractor: WeatherDataInteractor = WeatherDataInteractorImpl()

  var city: DomainCity!
  
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var mainDesciptionLabel: UILabel!
  @IBOutlet weak var currTempLabel: UILabel!
  @IBOutlet weak var minTempLabel: UILabel!
  @IBOutlet weak var maxTempLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = city.name
    SVProgressHUD.show(withStatus: "Adatok letoltese...")
    weatherInteractor.getWeatherDataForCity(cityName: city.name!, callback: self)
  }
  
}

extension WeatherViewController: GetWeatherDataForCityCallback {
  
  func getWeatherDataForCitySuccess(weatherData: CloudWeatherData) {
    mainDesciptionLabel.text = weatherData.weather?[0].main ?? "Unknown"
    if let temp = weatherData.main?.temp {
      currTempLabel.text = String(format:"%.0f", temp) + " °C"
    }
    if let minTemp = weatherData.main?.temp_min {
      minTempLabel.text = String(format:"%.0f", minTemp) + " °C"
    }
    if let maxTemp = weatherData.main?.temp_max {
      maxTempLabel.text = String(format:"%.0f", maxTemp) + " °C"
    }
    iconImageView.sd_setImage(with: URL(string: "http://openweathermap.org/img/w/" + (weatherData.weather?[0].icon ?? "") + ".png"), placeholderImage: UIImage(named: "error"))
    
    SVProgressHUD.dismiss()
  }
  
  func getWeatherDataForCityError() {
    SVProgressHUD.dismiss()
    SVProgressHUD.showError(withStatus: "Hiba az adatok lekerese soran...")
  }
  
}
