//
//  Themes.swift
//  MunchkinsCounter
//
//  Created by Vitaly Chernish on 24.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import Foundation
import UIKit

class MunchkinThemes {
    
    static let shared = MunchkinThemes()
    
    var themes = [Theme]()
    
    init() {
        setupNewTheme(with: .MrBin, mainImage: #imageLiteral(resourceName: "lvl3"), subPictures: [#imageLiteral(resourceName: "lvl1"), #imageLiteral(resourceName: "lvl2"), #imageLiteral(resourceName: "lvl3"), #imageLiteral(resourceName: "lvl4"), #imageLiteral(resourceName: "lvl5"), #imageLiteral(resourceName: "lvl6"), #imageLiteral(resourceName: "lvl7"), #imageLiteral(resourceName: "lvl8"), #imageLiteral(resourceName: "lvl9"), #imageLiteral(resourceName: "lvl10")])
        setupNewTheme(with: .MyLittlePony, mainImage: #imageLiteral(resourceName: "ponyLvl2"), subPictures: [#imageLiteral(resourceName: "ponyLvl1"), #imageLiteral(resourceName: "ponyLvl2"), #imageLiteral(resourceName: "ponyLvl3"), #imageLiteral(resourceName: "ponyLvl4"), #imageLiteral(resourceName: "ponyLvl5"), #imageLiteral(resourceName: "ponyLvl6"), #imageLiteral(resourceName: "ponyLvl7"), #imageLiteral(resourceName: "ponyLvl8"), #imageLiteral(resourceName: "ponyLvl9"), #imageLiteral(resourceName: "ponyLvl10")])
    }
    
    func setupNewTheme(with header: ThemeHeader, mainImage: UIImage, subPictures: [UIImage]) {
        let newTheme = Theme()
        newTheme.header = header
        newTheme.mainImage = mainImage
        newTheme.subPictures = subPictures
        themes.append(newTheme)
    }
    
    func applyTheme(_ theme: Theme, forMunchkin munchkin: Munchkin) {
        munchkin.applyTheme(theme)
    }
    
}
