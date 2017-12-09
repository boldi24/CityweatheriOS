//
//  NetworkManager.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 09/12/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import Alamofire
import Foundation

class NetworkManager: WeatherRepository {
  
  static let shared = NetworkManager()
  
  private init() {
    
  }
  
  func getWeatherForCity(name: String, callback: WeatherRepositoryCallback) {
    var paramaters = [String: String]()
    paramaters["q"] = name
    paramaters["units"] = "metric"
    paramaters["appid"] = APIURLS.AppId
    Alamofire.request(APIURLS.BaseUrl+APIURLS.GetUrl, method: .get, parameters: paramaters).responseJSON { response in
      print("Request: \(response.request)")
      print("Response: \(response.response)")
      print("Error: \(response.error)")
      
      if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
        print("Data: \(utf8Text)")
      }
    }
  }
  
  
}
