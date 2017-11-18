//
//  WeatherViewController.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 18/11/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
  
  var city: DomainCity!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = city.name
    // Do any additional setup after loading the view.
  }
  
  
}
