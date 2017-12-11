//
//  DomainWeatherData.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 11/12/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import Foundation

class DomainWeatherData {
  var mainDesc: String?
  var icon: String?
  var currTemp: Double?
  var maxTemp: Double?
  var minTemp: Double?
  
  init(mainDesc: String?, icon: String?, currTemp: Double?, maxTemp: Double?, minTemp: Double?) {
    self.mainDesc = mainDesc
    self.icon = icon
    self.currTemp = currTemp
    self.maxTemp = maxTemp
    self.minTemp = minTemp
  }
}
