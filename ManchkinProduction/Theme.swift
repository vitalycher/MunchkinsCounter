//
//  Theme.swift
//  MunchkinsCounter
//
//  Created by Vitaly Chernish on 24.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import Foundation
import UIKit

enum ThemeHeader: String {
    
    case MrBin = "Mr. Bin Theme"
    case MyLittlePony = "My Little Pony Theme"
    
}

class Theme {
    
    var header: ThemeHeader?
    var mainImage: UIImage?
    var subPictures: [UIImage]?
    
}
