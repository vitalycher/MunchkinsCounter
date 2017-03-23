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

class MunchkinSetupTableViewCell: UITableViewCell {
    
    var manchkin: Munchkin? {
        didSet {
            manchkin?.name.subscribeNext { [weak self] in self?.playerNameTextField.text = $0
                }.ownedBy(self).putInto(self.pool)
        }
        
    }
    weak var delegate: ChangableWithMunchkinName?
    
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
            self?.manchkin?.applyName($0)
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
        delegate?.cellDidRequestToApplyMunchkinName(cell: self)
    }
    
    @objc private func chooseImageTheme(sender: UITapGestureRecognizer) {
        if let parentViewController = self.parentViewController {
            parentViewController.performSegue(withIdentifier: "ThemePickerSegue", sender: nil)
        }
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
