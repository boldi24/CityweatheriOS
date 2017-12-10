//
//  DiskWeatherDataStore.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 10/12/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import Foundation

protocol DiskWeatherDataStore {
  //func getWeatherDataForCity(cityName: String) -> DiskWeatherData
  func saveWeatherData(weatherData: DiskWeatherData)
  func isWeatherCachedForCity(cityName: String) -> Bool
}
