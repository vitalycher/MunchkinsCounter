//
//  MunchkinValidator.swift
//  MunchkinsCounter
//
//  Created by Vitaly Chernish on 27.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import Foundation

struct Validator<T> {
    
    var condition: (T) -> Bool
    
    func check(_ value: T) -> Bool {
        return condition(value)
    }
    
}

func &&<T>(lhs: Validator<T>, rhs: Validator<T>) -> Validator<T> {
    return Validator { lhs.check($0) && rhs.check($0) }
}

func ||<T>(lhs: Validator<T>, rhs: Validator<T>) -> Validator<T> {
    return Validator { lhs.check($0) || rhs.check($0) }
}

func !=<T>(lhs: Validator<T>, rhs: Validator<T>) -> Validator<T> {
    return Validator { lhs.check($0) != rhs.check($0) }
}

prefix func !<T>(lhs: Validator<T>) -> Validator<T> {
    return Validator { !lhs.check($0) }
}
