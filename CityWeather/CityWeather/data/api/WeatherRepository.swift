//
//  WeatherRepository.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 09/12/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import Foundation

protocol WeatherRepository {
  func getWeatherForCity(name: String, callback: WeatherRepositoryCallback)
}

protocol WeatherRepositoryCallback {
  func onGetWeatherForCitySuccess(weatherData: DomainWeatherData)
  func onGetWeatherForCityError()
}
