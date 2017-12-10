//
//  WeatherDataInteractorImpl.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 10/12/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import Foundation

class WeatherDataInteractorImpl: WeatherDataInteractor {
  
  private let weatherRepository: WeatherRepository = NetworkManager.shared
  
  var callback: GetWeatherDataForCityCallback!
  
  func getWeatherDataForCity(cityName: String, callback: GetWeatherDataForCityCallback) {
    self.callback = callback
    weatherRepository.getWeatherForCity(name: cityName, callback: self)
  }
  
}

extension WeatherDataInteractorImpl: WeatherRepositoryCallback {
  
  func onGetWeatherForCitySuccess(cloudWeatherData: CloudWeatherData) {
    callback.getWeatherDataForCitySuccess(weatherData: cloudWeatherData)
  }
  
  func onGetWeatherForCityError() {
    callback.getWeatherDataForCityError()
  }
  
  
}
