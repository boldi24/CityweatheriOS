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
    //fetchedResultsController.delegate = self
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
  }
  
  func updateCity(city: DomainCity, at indexPath: IndexPath) {
    let cityToUpdate = fetchedResultsController.object(at: indexPath)
    cityToUpdate.name = city.name
    cityToUpdate.isFavourite = city.favorite!
  }
  
  func getCities() -> [City]? {
    print("Fetch cities ")
    print(fetchedResultsController.fetchedObjects!.count)
    return fetchedResultsController.fetchedObjects
  }
  
}

//extension CoreDataCityDataStore: NSFetchedResultsControllerDelegate {
//  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//    tableView.beginUpdates()
//  }
//
//  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//    switch type {
//    case .insert:
//      tableView.insertRows(at: [newIndexPath!], with: .automatic)
//    case .delete:
//      tableView.deleteRows(at: [indexPath!], with: .automatic)
//    case .update:
//      let cell = tableView.cellForRow(at: indexPath!)!
//      configure(cell: cell, at: indexPath!)
//    case .move:
//      tableView.deleteRows(at: [indexPath!], with: .automatic)
//      tableView.insertRows(at: [newIndexPath!], with: .automatic)
//    }
//  }
//
//  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//    tableView.endUpdates()
//  }
//}

