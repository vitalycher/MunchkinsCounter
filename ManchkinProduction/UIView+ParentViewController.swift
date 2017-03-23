//
//  UIView+ParentViewController.swift
//  ManchkinProduction
//
//  Created by Vitaly Chernish on 17.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import UIKit

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as! UIViewController!
            }
        }
        return nil
    }
}
