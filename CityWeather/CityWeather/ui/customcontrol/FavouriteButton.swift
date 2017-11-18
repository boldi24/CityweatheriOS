//
//  FavouriteButton.swift
//  CityWeather
//
//  Created by Boldizsár Tömpe on 18/11/2017.
//  Copyright © 2017 Boldizsár Tömpe. All rights reserved.
//

import UIKit

@IBDesignable
class FavouriteButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    private func initButton() {
        isSelected = false
        let bundle = Bundle(for: type(of: self))
        backgroundColor = UIColor.clear
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let filledStar = UIImage(named:"filledStar", in: bundle, compatibleWith: self.traitCollection)
        setBackgroundImage(emptyStar, for: UIControlState.normal)
        setBackgroundImage(filledStar, for: UIControlState.selected)
        addTarget(self, action: #selector(FavouriteButton.onClick(button:)), for: .touchUpInside)
    }
    
    @objc func onClick(button: UIButton) {
        isSelected = !isSelected
    }
}
