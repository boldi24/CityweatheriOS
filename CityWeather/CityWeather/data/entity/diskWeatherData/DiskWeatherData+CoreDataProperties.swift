//
//  DiskWeatherData+CoreDataProperties.swift
//  
//
//  Created by Boldizsár Tömpe on 10/12/2017.
//
//

import Foundation
import CoreData


extension DiskWeatherData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiskWeatherData> {
        return NSFetchRequest<DiskWeatherData>(entityName: "DiskWeatherData")
    }

    @NSManaged public var desc: String?
    @NSManaged public var icon: String?
    @NSManaged public var main: String?
    @NSManaged public var maxTemp: Double
    @NSManaged public var minTemp: Double
    @NSManaged public var temp: Double
    @NSManaged public var timeStamp: Int64
    @NSManaged public var windSpeed: Double
    @NSManaged public var city: City?

}
