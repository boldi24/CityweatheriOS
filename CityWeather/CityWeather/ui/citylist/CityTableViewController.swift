//
//  CitiesTableViewController.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 17/11/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController {
  
  private var cities = [DomainCity]()
  private let interactor = CityInteractorImpl()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
    cities = interactor.getCities()!
  }
  
  private func loadSamples() {
    let city1 = DomainCity(name: "London", favorite: nil)
    let city2 = DomainCity(name: "Budapest", favorite: nil)
    cities += ([city1, city2])
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cities.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "CityTableViewCell"
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CityTableViewCell  else {
      fatalError("The dequeued cell is not an instance of CityTableViewCell.")
    }
    cell.selectionDelegate = self
    cell.cityLabel.text = cities[indexPath.row].name
    cell.favButton.isSelected = cities[indexPath.row].favorite!
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  // Override to support conditional editing of the table view.
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      cities.remove(at: indexPath.row)
      interactor.deleteCity(at: indexPath)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
 
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  private func addCity(name: String) {
    let city = DomainCity(name: name, favorite: false)
    cities.append(city)
    let path = IndexPath(row: cities.count-1, section: 0)
    tableView.insertRows(at: [path], with: UITableViewRowAnimation.automatic)
    interactor.saveCity(city: city)
  }
  
  @IBAction func addCityButtonTap(_ sender: Any) {
    let createCityAlert = UIAlertController(title: "Add new city", message: "Enter the city name", preferredStyle: .alert)
    
    createCityAlert.addTextField() {
      textField in
      textField.placeholder = "Your new city"
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    createCityAlert.addAction(cancelAction)
    
    let createAction = UIAlertAction(title: "Create", style: .default) {
      action in
      
      let textField = createCityAlert.textFields!.first!
      self.addCity(name: textField.text!)
    }
    createCityAlert.addAction(createAction)
    
    present(createCityAlert, animated: true, completion: nil)
  }
  
}

extension CityTableViewController: SelectionCallback {
  func onFavoriteButtonTouchUpInside(of cell: UITableViewCell) {
    print("bement")
    let indexPath = tableView.indexPath(for: cell)
    if let indexPathUnwrapped = indexPath {
      print("Updating city at \(indexPathUnwrapped.row)")
      let city = cities[indexPathUnwrapped.row]
      city.favorite = !city.favorite!
      interactor.updateCity(city: city, at: indexPathUnwrapped)
    }

  }
}
