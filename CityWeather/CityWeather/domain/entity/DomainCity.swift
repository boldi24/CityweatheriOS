//
//  DomainCity.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 18/11/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

class DomainCity {
    var name: String?
    var favorite: Bool?
    
    init(name: String, favorite: Bool?) {
        self.name = name
        self.favorite = favorite
    }
}
