//
//  Manchkins.swift
//  ManchkinProduction
//
//  Created by Vitaly Chernish on 13.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import Foundation
import ModelsTreeKit

class MunchkinsDatabase {
    
    static let shared = MunchkinsDatabase()
    
    var winPipe = ModelsTreeKit.Pipe<Munchkin>()
    var munchkinsCountAcceptedPipe = ModelsTreeKit.Pipe<Void>()
    var errorPipe = ModelsTreeKit.Pipe<(title: String, message: String)>()
    
    var munchkins = [Munchkin]()
    
    func initializeMunchkins(with munchkinNumber: String?) {
        if let stringNumber = munchkinNumber {
            if let number = Int(stringNumber) {
                switch number {
                case 2...10:
                    munchkinsCountAcceptedPipe.sendNext()
                    for _ in 0..<number {
                        munchkins.append(Munchkin())
                    }
                case 0...1: errorPipe.sendNext(ApplicationMessages.notEnoughPlayers)
                default: errorPipe.sendNext(ApplicationMessages.tooMuchPlayers)
                }
                
            } else {
                errorPipe.sendNext(ApplicationMessages.didNotRecognizeNumber)
            }
        } else {
            errorPipe.sendNext(ApplicationMessages.nullNumber)
        }
    }
    
    func cleanDatabase() {
        munchkins.removeAll()
    }
    
    func increaseMunchkinLevel(at index: Int?) {
        if let index = index {
            let munchkin = munchkins[index]
            if munchkin.canAddLevel() {
                munchkin.addLevel()
            } else {
                winPipe.sendNext(munchkin)
            }
        }
    }
    
    func decreaseMunchkinLevel(at index: Int?) {
        if let index = index {
            let munchkin = munchkins[index]
            munchkin.decreaseLevel()
        }
    }
    
    func chooseRandomNameForMunchkin(at index: Int?) {
        if let index = index {
            let munchkin = munchkins[index]
            munchkin.applyRandomName()
        }
    }
    
}
