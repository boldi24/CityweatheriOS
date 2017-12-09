//
//  CityTableViewCell.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 17/11/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
  
  var selectionDelegate: SelectionCallback!
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var favButton: FavouriteButton!
  var index: Int!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  @IBAction func onFavoriteButtonTouchUpInside(_ sender: Any) {
    print("selected")
    selectionDelegate.onFavoriteButtonTouchUpInside(of: index)
  }
  
}
