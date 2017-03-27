//
//  BasementValidators.swift
//  MunchkinsCounter
//
//  Created by Vitaly Chernish on 27.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import Foundation

extension ApplicationValidators {
    
    static let nameValidator = longerThan(2) && shorterThan(12)
    
    static let allowedMunchkinsCount = inRange(2, upperbound: 10)
    
    static let lowMunchkinsCount = lowerThan(2)

}
