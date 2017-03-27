//
//  GameViewController.swift
//  ManchkinProduction
//
//  Created by Vitaly Chernish on 15.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import UIKit
import HandyText
import SDCAlertView

class GameViewController: UIViewController {
    
    @IBOutlet weak fileprivate var gameTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MunchkinsDatabase.shared.winPipe.subscribeNext { [weak self] in
            let munchkinName = $0.name.value
            self?.showWinAlert(for: munchkinName) }.ownedBy(self)
        
        gameTableView.tableFooterView = UIView()
    }
    
    @IBAction private func exitToMenu(_ sender: Any) {
        performSegue(withIdentifier: "UnwindToNumberVC", sender: self)
    }
    
    private func playAgain() {
        performSegue(withIdentifier: "UnwindToNumberVC", sender: self)
    }
    
    private func showWinAlert(for name: String) {
        let alert = AlertController(title: "", message: "", preferredStyle: .alert)
        
        let attributedAlertMessage = "Munchkin '\(name)' won!".withStyle(TextStyle.highlightedNameOfWinner.withAlignment(.center)).applyStyle(TextStyle.skySearchlight.withAlignment(.center), toOccurencesOf: "'\(name)'")
        
        let playAgainAction = AlertAction(title: "Play again", style: AlertActionStyle.preferred, handler: { _ in self.playAgain() })
        
        alert.add(playAgainAction)
        alert.add(AlertAction(title: "Cancel", style: .destructive))

        alert.attributedMessage = attributedAlertMessage
        alert.present()
    }
    
    fileprivate func showCantDecreaseLevelAlert(with title: String, andMessage message: String) {
         let alert = AlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.add(AlertAction(title: ApplicationMessages.confirmMessage, style: .normal))
        alert.present()
    }
    
}

extension GameViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MunchkinsDatabase.shared.munchkins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as? GameTableViewCell {
            cell.delegate = self
            cell.munchkin = MunchkinsDatabase.shared.munchkins[indexPath.row]
            return cell
        } else {
            return UITableViewCell.init()
        }
    }
    
}

extension GameViewController: ChangableWithMunchkinLevel {
    
    func cellDidRequestToIncreaseLevel(cell: UITableViewCell) {
        let index = gameTableView.indexPath(for: cell)?.row
        MunchkinsDatabase.shared.increaseMunchkinLevel(at: index)
    }
    
    func cellDidRequestToDecreaseLevel(cell: UITableViewCell) {
        let index = gameTableView.indexPath(for: cell)?.row
        MunchkinsDatabase.shared.decreaseMunchkinLevel(at: index).subscribeNext { [weak self] in if let error = $0 {
            self?.showCantDecreaseLevelAlert(with: error.message, andMessage: error.title)
            } }.autodispose()
    }
    
}
