//
//  ManchkinNumberViewController.swift
//  ManchkinProduction
//
//  Created by Vitaly Chernish on 13.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import UIKit
import ModelsTreeKit
import SDCAlertView

class MunchkinNumberViewController: UIViewController {

    @IBOutlet weak private var manchkinNumberTextField: UITextField!
    @IBOutlet weak private var procceedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MunchkinsDatabase.shared.errorPipe.subscribeNext { [weak self] in self?.showWrongMunchkinNumberAlert(with: $0.title, andMessage: $0.message) }.ownedBy(self)
        
        MunchkinsDatabase.shared.munchkinsCountAcceptedPipe.subscribeNext { [weak self] in self?.performSegue(withIdentifier: "InitializeMunchkinsSegue", sender: nil) }.ownedBy(self)
        
        procceedButton.selectionSignal.subscribeNext { [weak self] in MunchkinsDatabase.shared.initializeMunchkins(with: self?.manchkinNumberTextField.text) }.ownedBy(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MunchkinsDatabase.shared.cleanDatabase()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manchkinNumberTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        manchkinNumberTextField.resignFirstResponder()
    }
    
    @IBAction private func exitToMainMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func showWrongMunchkinNumberAlert(with title: String, andMessage message: String) {
        let alert = AlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.add(AlertAction(title: ApplicationMessages.confirmMessage, style: .normal))
        alert.present()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
    
    @IBAction private func unwindToNumberVC(segue: UIStoryboardSegue) { }
    
}
