//
//  ApplicationTextStyles.swift
//  MunchkinsCounter
//
//  Created by Vitaly Chernish on 22.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import Foundation
import HandyText

extension Font {
    
    static var Cochin: Font {
        return Font(
            regular: "Cochin-Regular",
            bold: "Cochin-Bold")
    }
    
}

extension TextStyle {
    
    //MARK: - Styles
    static var highlightedNameOfWinner: TextStyle {
        return TextStyle(font: .Cochin).withSize(16).bold()
    }
    
    static var messageBody: TextStyle {
        return TextStyle(font: .Cochin)
    }
    
    
    //MARK: - Style setup
    static var skySearchlight: TextStyle {
        return highlightedNameOfWinner.withForegroundColor(.black).bold().withSize(20)
    }
    
    static var nocturnalMessage: TextStyle {
        return messageBody.withForegroundColor(.black).bold().withSize(17)
    }
    
}
