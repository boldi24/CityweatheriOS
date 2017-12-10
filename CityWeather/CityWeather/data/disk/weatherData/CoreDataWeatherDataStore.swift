//
//  CoreDataWeatherDataStore.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 10/12/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import CoreData
import Foundation

class CoreDataWeatherDataStore: NSObject, DiskWeatherDataStore {
  
  static let shared = CoreDataWeatherDataStore()
  private let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
  
  private override init() {
    
  }

  
//  func getWeatherDataForCity(cityName: String) -> DiskWeatherData {
//    return nil
//  }
  
  func isWeatherCachedForCity(cityName: String) -> Bool {
    return false
  }
  
  func saveWeatherData(weatherData: DiskWeatherData) {
    
  }
  
  
}
