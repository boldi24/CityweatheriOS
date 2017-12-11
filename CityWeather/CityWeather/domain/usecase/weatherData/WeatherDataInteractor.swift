//
//  WeatherDataInteractor.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 10/12/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import Foundation

protocol WeatherDataInteractor {
  func getWeatherDataForCity(cityName: String, callback: GetWeatherDataForCityCallback)
}

protocol GetWeatherDataForCityCallback {
  func getWeatherDataForCitySuccess (weatherData: DomainWeatherData)
  func getWeatherDataForCityError ()
}
