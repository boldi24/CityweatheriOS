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
  private let cityDataStore: DiskCityDataStore = CoreDataCityDataStore.shared
  
  var callback: GetWeatherDataForCityCallback!
  var cityName: String!
  
  func getWeatherDataForCity(cityName: String, callback: GetWeatherDataForCityCallback) {
    self.callback = callback
    self.cityName = cityName
    if cityDataStore.isWeatherCachedForCity(name: cityName) {
      print("Weather chached for \(cityName)...")
      callback.getWeatherDataForCitySuccess(weatherData: cityDataStore.getWeatherOfCity(name: cityName)!)
    } else {
      print("Weather not cached for \(cityName)...")
      weatherRepository.getWeatherForCity(name: cityName, callback: self)
    }
  }
  
}

extension WeatherDataInteractorImpl: WeatherRepositoryCallback {

  func onGetWeatherForCitySuccess(weatherData: DomainWeatherData) {
    callback.getWeatherDataForCitySuccess(weatherData: weatherData)
    cityDataStore.saveWeatherOfCity(name: cityName, weather: weatherData)
  }
  
  func onGetWeatherForCityError() {
    callback.getWeatherDataForCityError()
  }
  
  
}
