//
//  City+CoreDataProperties.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 17/11/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var weather: WeatherData?

}
