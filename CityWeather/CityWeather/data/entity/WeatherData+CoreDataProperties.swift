//
//  WeatherData+CoreDataProperties.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 17/11/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//
//

import Foundation
import CoreData


extension WeatherData {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherData> {
    return NSFetchRequest<WeatherData>(entityName: "WeatherData")
  }
  
  @NSManaged public var city: String?
  @NSManaged public var windSpeed: Double
  @NSManaged public var temp: Double
  @NSManaged public var minTemp: Double
  @NSManaged public var maxTemp: Double
  @NSManaged public var icon: String?
  @NSManaged public var main: String?
  @NSManaged public var desc: String?
  
}
