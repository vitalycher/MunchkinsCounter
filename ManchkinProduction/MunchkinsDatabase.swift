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
    
    var munchkins = [Munchkin]() {
        didSet {
           summaryValiditySignal = munchkins.map { $0.isValid }.reduce(Observable(true)) { result, element in result && element }.observable()
        }
    }

    var summaryValiditySignal: Signal<Bool>?
    
    typealias ErrorMessageWithDescription = (title: String, message: String)
    
    func initializeMunchkins(with munchkinNumber: String?) -> Signal<ErrorMessageWithDescription?> {
        let errorObservable = Observable<ErrorMessageWithDescription?>(nil)
        var error: ErrorMessageWithDescription?
        
        if let stringNumber = munchkinNumber {
            if let number = Int(stringNumber) {
                
                if ApplicationValidators.allowedMunchkinsCount.check(number) {
                    munchkinsCountAcceptedPipe.sendNext()
                    for _ in 0..<number {
                        munchkins.append(Munchkin())
                    }
                } else if ApplicationValidators.lowMunchkinsCount.check(number) {
                    error = ApplicationMessages.notEnoughPlayers
                } else {
                   error = ApplicationMessages.tooMuchPlayers
                }
                
            } else {
                error = ApplicationMessages.didNotRecognizeNumber
            }
        } else {
            error = ApplicationMessages.nullNumber
        }
        errorObservable.value = error
        return errorObservable
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
    
    func decreaseMunchkinLevel(at index: Int?) -> Signal<ErrorMessageWithDescription?> {
        let munchkin = munchkins[index!]
        return tryDecreaseLevel(for: munchkin)
    }
    
    func tryDecreaseLevel(for munchkin: Munchkin) -> Signal<ErrorMessageWithDescription?> {
        let result = munchkin.decreaseLevelIfPossible()
        let resultSignal = Observable<ErrorMessageWithDescription?>(nil)
        if result == false {
            resultSignal.value = ApplicationMessages.cantDecreaseMunchkinLevel
        }
        return resultSignal
    }
    
    func chooseRandomNameForMunchkin(at index: Int?) {
        if let index = index {
            let munchkin = munchkins[index]
            munchkin.applyRandomName()
        }
    }
    
}
