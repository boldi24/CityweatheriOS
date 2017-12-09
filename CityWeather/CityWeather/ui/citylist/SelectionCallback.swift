//
//  SelectionCallback.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 18/11/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import UIKit

protocol SelectionCallback {
  func onFavoriteButtonTouchUpInside(of cellAtIndex: Int)
}
