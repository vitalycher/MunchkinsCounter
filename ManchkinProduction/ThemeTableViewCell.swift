//
//  ThemeTableViewCell.swift
//  MunchkinsCounter
//
//  Created by Vitaly Chernish on 24.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import UIKit
import ModelsTreeKit

protocol AppliableWithTheme: class {
    
    func cellDidRequestToApplyTheme(cell: UITableViewCell, theme: Theme)
    
}

class ThemeTableViewCell: UITableViewCell {

    var theme: Theme? {
        didSet {
            themeImageView.image = theme?.mainImage
            headerLabel.text = theme?.header?.rawValue
        }
    }
    
    weak var themeApplyDelegate: AppliableWithTheme?
    
    @IBOutlet weak private var headerLabel: UILabel!
    @IBOutlet weak private var themeImageView: UIImageView!
    @IBOutlet weak private var chooseTheme: UIButton!
    
    override func awakeFromNib() {
        chooseTheme.selectionSignal.subscribeNext { [weak self] in
            self?.themeApplyDelegate?.cellDidRequestToApplyTheme(cell: self!, theme: self?.theme ?? Theme()) }.ownedBy(self)
    }
    
}
