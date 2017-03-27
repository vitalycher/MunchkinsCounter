//
//  GameTableViewCell.swift
//  ManchkinProduction
//
//  Created by Vitaly Chernish on 15.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import UIKit

protocol ChangableWithMunchkinLevel: class {
    
    func cellDidRequestToIncreaseLevel(cell: UITableViewCell) -> Void
    func cellDidRequestToDecreaseLevel(cell: UITableViewCell) -> Void
    
}

class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var playerNameLabel: UILabel!
    @IBOutlet weak private var playerImageView: UIImageView!
    @IBOutlet weak private var levelLabel: UILabel!
    @IBOutlet weak var increaseLevelButton: UIButton!
    @IBOutlet weak var decreaseLevelButton: UIButton!
    
    weak var delegate: ChangableWithMunchkinLevel?
    
    var munchkin: Munchkin? {
        didSet {
            playerNameLabel.text = munchkin?.name.value
            
            munchkin?.level.subscribeNext { [weak self] in
                self?.levelLabel.text = String(describing: $0)
                }.putInto(self.pool)
            
            munchkin?.image.subscribeNext { [weak self] in
                self?.playerImageView.image = $0
                }.ownedBy(self).putInto(self.pool)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        increaseLevelButton.selectionSignal.subscribeNext { [weak self] in self?.delegate?.cellDidRequestToIncreaseLevel(cell: self ?? UITableViewCell.init()) }.ownedBy(self)
        decreaseLevelButton.selectionSignal.subscribeNext { [weak self] in self?.delegate?.cellDidRequestToDecreaseLevel(cell: self ?? UITableViewCell.init()) }.ownedBy(self)
        
        playerImageView.layer.cornerRadius = playerImageView.frame.size.width / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pool.drain()
    }
    
    private func setManchkinName(with name: String) {
        munchkin?.name.value = name
    }
    
}
