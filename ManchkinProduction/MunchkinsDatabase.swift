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
            summaryValiditySignal = munchkins.map { $0.isValid }.reduce(Observable(true), &&).observable()
            munchkins.forEach { munchkin in munchkin.isWinner().subscribeNext { [weak self] isWinner in if isWinner { self?.winPipe.sendNext(munchkin) } } }
        }
    }
    
    var summaryValiditySignal = Observable(false)
    
    typealias ErrorMessageWithDescription = (title: String, message: String)
    
    func initializeMunchkins(with munchkinNumber: String?) -> Signal<ErrorMessageWithDescription?> {
        let errorObservable = Observable<ErrorMessageWithDescription?>(nil)
        var error: ErrorMessageWithDescription?
        
        if let stringNumber = munchkinNumber {
            if let number = Int(stringNumber) {
                
                if Validators.allowedMunchkinsCount.check(number) {
                    munchkinsCountAcceptedPipe.sendNext()
                    for _ in 0..<number {
                        munchkins.append(Munchkin())
                    }
                } else if Validators.lowMunchkinsCount.check(number) {
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
            munchkin.addLevelIfPossible()
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
    
    func applyNameForMunchkin(at index: Int?, withName name: String?) {
        if let index = index {
            let munchkin = munchkins[index]
            if let name = name {
                munchkin.applyName(name)
            } else {
               munchkin.applyRandomName()
            }
        }
    }
    
}
