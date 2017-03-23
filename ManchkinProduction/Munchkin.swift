//
//  Manchkin.swift
//  ManchkinProduction
//
//  Created by Vitaly Chernish on 15.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import Foundation
import ModelsTreeKit

class Munchkin {
    
    var name = Observable("")
    var level = Observable(1)
    var image = Observable(UIImage())
    
    init() {
        selectImageAccordingToLevel()
    }
    
    func selectImageAccordingToLevel() {
        switch level.value {
        case 1: image.value = #imageLiteral(resourceName: "lvl1")
        case 2: image.value = #imageLiteral(resourceName: "lvl2")
        case 3: image.value = #imageLiteral(resourceName: "lvl3")
        case 4: image.value = #imageLiteral(resourceName: "lvl4")
        case 5: image.value = #imageLiteral(resourceName: "lvl5")
        case 6: image.value = #imageLiteral(resourceName: "lvl6")
        case 7: image.value = #imageLiteral(resourceName: "lvl7")
        case 8: image.value = #imageLiteral(resourceName: "lvl8")
        case 9: image.value = #imageLiteral(resourceName: "lvl9")
        case 10: image.value = #imageLiteral(resourceName: "lvl10")
        default: image.value = #imageLiteral(resourceName: "lvl1")
        }
    }
    
    func applyRandomName() {
        let randomNumber = Int(arc4random_uniform(10))
        switch randomNumber {
        case 0: name.value = "Вантуз"
        case 1: name.value = "Пукиш"
        case 2: name.value = "Лапоть"
        case 3: name.value = "Коготь"
        case 4: name.value = "Омлет"
        case 5: name.value = "Зубочистка"
        case 6: name.value = "Утка"
        case 7: name.value = "Кукиш"
        case 8: name.value = "Камыш"
        case 9: name.value = "Янукович"
        default:
            name.value = "Unnamed"
        }
    }
    
    func applyName(_ name: String) {
        self.name.value = name
    }
    
    func canAddLevel() -> Bool {
        if level.value > 9 {
            return false
        } else if level.value <= 9 {
            return true
        } else {
            return false
        }
    }
    
    func addLevel() {
        level.value += 1
        selectImageAccordingToLevel()
        if level.value == 10 {
            MunchkinsDatabase.shared.winPipe.sendNext(self)
        }
    }
    
    func decreaseLevel() {
        if level.value > 1 {
            level.value -= 1
            selectImageAccordingToLevel()
        } else {
            MunchkinsDatabase.shared.errorPipe.sendNext(ApplicationMessages.cantDecreaseMunchkinLevel)
        }
    }
    
}
