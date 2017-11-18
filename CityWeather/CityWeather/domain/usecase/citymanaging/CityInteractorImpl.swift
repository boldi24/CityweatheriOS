//
//  CityInteractorImpl.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 18/11/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import Foundation

class CityInteractorImpl: CityInteractor {
  
  private let cityDataStore: DiskCityDataStore = CoreDataCityDataStore.shared
  
  func saveCity(city: DomainCity) {
    cityDataStore.saveCity(city: city)
  }
  
  func deleteCity(at indexPath: IndexPath) {
    cityDataStore.deleteCity(at: indexPath)
  }
  
  func updateCity(city: DomainCity, at indexPath: IndexPath) {
    cityDataStore.updateCity(city: city, at: indexPath)
  }
  
  func getCities() -> [DomainCity]? {
    let cities = cityDataStore.getCities();
    return cities?.map {convertCityToDomainCity(city: $0)}
  }
  
  private func convertCityToDomainCity(city: City) -> DomainCity {
    return DomainCity(name: city.name!, favorite: city.isFavourite)
  }
  
  
}
