//
//  City+CoreDataProperties.swift
//  
//
//  Created by Boldizsár Tömpe on 10/12/2017.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "DiskCity")
    }

    @NSManaged public var isFavourite: Bool
    @NSManaged public var name: String?
    @NSManaged public var weather: DiskWeatherData?

}
