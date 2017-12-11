//
//  CoreDataCityDataStore.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 18/11/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import CoreData

class CoreDataCityDataStore: NSObject, DiskCityDataStore {
  
  static let shared = CoreDataCityDataStore()
  private var fetchedResultsController: NSFetchedResultsController<City>!
  private let managedObjectContext = CoreDataStack.shared.persistentContainer.viewContext
  
  let CACHE_TIME_IN_SECONDS = 10 * 60 //10 mins in sec
  
  
  //TODO: irjuk at hogy ne legyen ez a controller hanem a fetchrequest legyen mindig mert az ujonnani elemeket nem tartoalmazza a controller hacsak nem kerunk callbacket
  private override init() {
    super.init()
    let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
    let sortDescriptor = NSSortDescriptor(key: #keyPath(City.isFavourite), ascending: false)
    fetchRequest.sortDescriptors = [sortDescriptor]
    fetchRequest.fetchBatchSize = 30
    fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                          managedObjectContext: managedObjectContext,
                                                          sectionNameKeyPath: nil,
                                                          cacheName: nil)
    fetchedResultsController.delegate = self
    do {
      try fetchedResultsController.performFetch()
    } catch let error as NSError {
      print("\(error.userInfo)")
    }
  }
  
  func deleteCity(at indexPath: IndexPath) {
    let cityToDelete = fetchedResultsController.object(at: indexPath)
    managedObjectContext.delete(cityToDelete)
  }
  
  func saveCity(city: DomainCity) {
    let newCity = City(context: managedObjectContext)
    newCity.name = city.name
    newCity.isFavourite = city.favorite!
    print(fetchedResultsController.fetchedObjects!.count)
  }
  
  func updateCity(city: DomainCity, at indexPath: IndexPath) {
    print(fetchedResultsController.fetchedObjects!.count)
    let cityToUpdate = fetchedResultsController.object(at: indexPath)
    cityToUpdate.isFavourite = city.favorite!
    if city.favorite! {
      UserDefaults(suiteName: "group.cityweather")!.setValue(city.name!, forKey: "favCity")
    }
  }
  
  func getCities() -> [City]? {
    print("Fetch cities ")
    print(fetchedResultsController.fetchedObjects!.count)
    return fetchedResultsController.fetchedObjects
  }
  
  func getCityByName(name: String) -> City? {
    let cities = fetchedResultsController.fetchedObjects
    return cities?.filter{ $0.name == name }.first
  }
  
  func getWeatherOfCity(name: String) -> DomainWeatherData? {
    let city = getCityByName(name: name)
    let cityWeather = city?.weather
    let weatherData = DomainWeatherData(mainDesc: cityWeather?.main, icon: cityWeather?.icon, currTemp: cityWeather?.temp, maxTemp: cityWeather?.maxTemp, minTemp: cityWeather?.minTemp)
    return weatherData
  }
  
  func isWeatherCachedForCity(name: String) -> Bool {
    let city = getCityByName(name: name)
    print("Checking is cached for \(name)...")
    if let weather = city?.weather {
      let isOld = Int64(Date().timeIntervalSince1970) - weather.timeStamp > CACHE_TIME_IN_SECONDS
      if isOld {
        print("Deleting cache for \(name) since it's too old...")
        city?.weather = nil
        return false
      } else {
        return true
      }
    }
    return false
  }
  
  func saveWeatherOfCity(name: String, weather: DomainWeatherData) {
    let newWeather = DiskWeatherData(context: managedObjectContext)
    newWeather.main = weather.mainDesc
    newWeather.icon = weather.icon
    if let currTemp = weather.currTemp {
      newWeather.temp = currTemp
    }
    if let minTemp = weather.minTemp {
      newWeather.minTemp = minTemp
    }
    if let maxTemp = weather.maxTemp {
      newWeather.maxTemp = maxTemp
    }
    let city = getCityByName(name: name)
    newWeather.timeStamp = Int64(Date().timeIntervalSince1970) //gives seconds not milisec
    city?.weather = newWeather
  }
  
}

extension CoreDataCityDataStore: NSFetchedResultsControllerDelegate {
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      print("Insert happened")
      print(fetchedResultsController.fetchedObjects!.count)
    case .update:
      print("Update happened")
      print(indexPath?.row)
    default:
      break
    }
    
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
  }
}

