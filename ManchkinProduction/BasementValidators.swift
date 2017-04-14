//
//  Validators.swift
//  MunchkinsCounter
//
//  Created by Vitaly Chernish on 27.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import Foundation

struct Validators {
    
    //MARK: String validators
    
    static func lengthEquals(_ length: Int) -> Validator<String> {
        return Validator { $0.characters.count == length }
    }
    
    static func longerThan(_ length: Int) -> Validator<String> {
        return Validator { $0.characters.count > length }
    }
    
    static func shorterThan(_ length: Int) -> Validator<String> {
        return Validator { $0.characters.count < length }
    }
    
    static func containsString(_ otherString: String) -> Validator<String> {
        return Validator { $0.contains(otherString) }
    }
    
    static func hasPrefix(_ prefix: String) -> Validator<String> {
        return Validator { $0.hasPrefix(prefix) }
    }
    
    static func hasSuffix(_ suffix: String) -> Validator<String> {
        return Validator { $0.hasSuffix(suffix) }
    }
    
    //MARK: Int validators
    
    static func inRange(_ lowerbound: Int, upperbound: Int) -> Validator<Int> {
        return Validator { $0 >= lowerbound && $0 <= upperbound }
    }
    
    static func lowerThan(_ lowerbound: Int) -> Validator<Int> {
        return Validator { $0 < lowerbound }
    }
    
}
