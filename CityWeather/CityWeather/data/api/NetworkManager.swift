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
      if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
        print("Data: \(utf8Text)")
        do {
          let jsonDecoder = JSONDecoder()
          let weatherData = try jsonDecoder.decode(CloudWeatherData.self, from: data)
          callback.onGetWeatherForCitySuccess(weatherData: self.convertCloudWeatherToDomain(cloudWeather: weatherData))
        } catch let decodeError {
          print("Error during JSON decoding: \(decodeError.localizedDescription)")
          callback.onGetWeatherForCityError()
        }
      }
    }
  }
  
  func convertCloudWeatherToDomain(cloudWeather: CloudWeatherData) -> DomainWeatherData {
    let domainWeather = DomainWeatherData(mainDesc: cloudWeather.weather?[0].main,
                                          icon: cloudWeather.weather?[0].icon,
                                          currTemp: cloudWeather.main?.temp,
                                          maxTemp: cloudWeather.main?.temp_max,
                                          minTemp: cloudWeather.main?.temp_min)
    return domainWeather
  }
  
  
}
