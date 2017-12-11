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

