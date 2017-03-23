//
//  ViewController.swift
//  ManchkinProduction
//
//  Created by Vitaly Chernish on 13.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import UIKit

class GreetingsViewController: UIViewController {

    @IBOutlet weak private var welcomeLabel: UILabel!
    @IBOutlet weak private var startButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MunchkinsDatabase.shared.cleanDatabase()
        
        let scale = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
        
        welcomeLabel.alpha = 0.0
        welcomeLabel.transform = scale
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.8, delay: 0.0, options: [], animations: {
            self.welcomeLabel.transform = CGAffineTransform.identity
            self.welcomeLabel.alpha = 1.0
        }, completion: nil)
    }

}
