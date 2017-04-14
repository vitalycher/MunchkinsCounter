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
    var theme = Observable(Theme())
    
    lazy var isValid: Signal<Bool> = self.name.map { Validators.nameValidator.check($0) }
            
    init() {
        theme.value = MunchkinThemes.shared.themes.first ?? Theme()
        selectImageAccordingToLevel()
    }
    
    func selectImageAccordingToLevel() {
        switch level.value {
        case 1: image.value = (theme.value.subPictures?[0])!
        case 2: image.value = (theme.value.subPictures?[1])!
        case 3: image.value = (theme.value.subPictures?[2])!
        case 4: image.value = (theme.value.subPictures?[3])!
        case 5: image.value = (theme.value.subPictures?[4])!
        case 6: image.value = (theme.value.subPictures?[5])!
        case 7: image.value = (theme.value.subPictures?[6])!
        case 8: image.value = (theme.value.subPictures?[7])!
        case 9: image.value = (theme.value.subPictures?[8])!
        case 10: image.value = (theme.value.subPictures?[9])!
        default: image.value = (theme.value.subPictures?[10])!
        }
    }
    
    func applyRandomName() {
        let randomNumber = Int(arc4random_uniform(10))
        switch randomNumber {
        case 0: name.value = "Уилл"
        case 1: name.value = "Долли"
        case 2: name.value = "Клык"
        case 3: name.value = "Коготь"
        case 4: name.value = "Омлет"
        case 5: name.value = "Зубочистка"
        case 6: name.value = "Утка"
        case 7: name.value = "Билл"
        case 8: name.value = "Камыш"
        case 9: name.value = "Якубович"
        default:
            name.value = "Unnamed"
        }
    }
    
    func applyName(_ name: String) {
        self.name.value = name
    }
    
    func addLevelIfPossible() {
        if level.value < 10 {
            level.value += 1
            selectImageAccordingToLevel()
        }
    }
    
    func isWinner() -> Signal<Bool> {
        return self.level.map { $0 == 10 }
    }
        
    func decreaseLevelIfPossible() -> Bool {
        if level.value > 1 {
            level.value -= 1
            selectImageAccordingToLevel()
            return true
        } else {
            return false
        }
    }
    
    func applyTheme(_ theme: Theme) {
        self.theme.value = theme
        selectImageAccordingToLevel()
    }
    
}
