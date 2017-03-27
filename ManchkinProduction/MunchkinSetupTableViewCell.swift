//
//  ManchkinTableViewCell.swift
//  ManchkinProduction
//
//  Created by Vitaly Chernish on 13.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import UIKit
import ModelsTreeKit

protocol ChangableWithMunchkinName: class {
    func cellDidRequestToApplyMunchkinName(cell: UITableViewCell)
}

protocol SelectableWithTheme: class {
    func cellDidRequestToOpenThemePicker(cell: UITableViewCell, munchkin: Munchkin)
}

class MunchkinSetupTableViewCell: UITableViewCell {
    
    var munchkin: Munchkin? {
        didSet {
            munchkin?.name.subscribeNext { [weak self] in self?.playerNameTextField.text = $0
                }.ownedBy(self).putInto(self.pool)
            munchkin?.theme.subscribeNext {[weak self] in self?.playerImageView.image = $0.mainImage;
                }.ownedBy(self)
        }
        
    }
    
    weak var munchkinNameDelegate: ChangableWithMunchkinName?
    weak var themePickerDelegate: SelectableWithTheme?
    
    @IBOutlet weak private var playerImageView: UIImageView!
    @IBOutlet weak private var playerNumberLabel: UILabel!
    @IBOutlet weak private var playerNameTextField: UITextField!
    @IBOutlet weak private var diceButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareForAnimation()
        animateElements()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MunchkinSetupTableViewCell.chooseImageTheme))
        
        playerNameTextField.textSignal.subscribeNext { [weak self] in
            self?.munchkin?.applyName($0)
            }.ownedBy(self)
        
        diceButton.selectionSignal.subscribeNext { [weak self] in
            self?.applyRandomName()
            }.ownedBy(self)
        
        playerImageView.isUserInteractionEnabled = true
        playerImageView.addGestureRecognizer(tap)
        playerImageView.layer.cornerRadius = playerImageView.frame.size.width / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pool.drain()
    }
    
    func applyPlayerNumber(with number: Int) {
        playerNumberLabel.text = "Munchkin №" + String(number + 1)
    }
    
    private func applyRandomName() {
        munchkinNameDelegate?.cellDidRequestToApplyMunchkinName(cell: self)
    }
    
    @objc private func chooseImageTheme(sender: UITapGestureRecognizer) {
        themePickerDelegate?.cellDidRequestToOpenThemePicker(cell: self, munchkin: munchkin ?? Munchkin())
    }
    
    private func prepareForAnimation() {
        playerNameTextField.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        playerImageView.transform = CGAffineTransform.init(scaleX: 0.25, y: 0.25)
        
    }
    
    private func animateElements() {
        UIView.animate(withDuration: 0.6, delay: 0.0, options: [], animations: {
            self.playerNameTextField.transform = CGAffineTransform.identity
            self.playerImageView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
}
