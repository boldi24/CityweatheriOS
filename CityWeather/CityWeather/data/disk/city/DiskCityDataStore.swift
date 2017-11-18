//
//  DiskCityDataStore.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 18/11/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import Foundation

protocol DiskCityDataStore {
  func saveCity(city: DomainCity)
  func deleteCity(at indexPath: IndexPath)
  func updateCity(city: DomainCity, at indexPath: IndexPath)
  func getCities() -> [City]? 
}
