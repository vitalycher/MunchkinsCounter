//
//  ManchkinNamesViewController.swift
//  ManchkinProduction
//
//  Created by Vitaly Chernish on 13.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import UIKit

class MunchkinNamesViewController: UIViewController {
    
    @IBOutlet weak fileprivate var munchkinTableView: UITableView!
    @IBOutlet weak private var startGameButton: UIBarButtonItem!
    
    fileprivate var munchkin = Munchkin()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MunchkinsDatabase.shared.summaryValiditySignal?.subscribeNext { [weak self] in self?.startGameButton.isEnabled = $0 }.ownedBy(self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MunchkinNamesViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MunchkinNamesViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        munchkinTableView.tableFooterView = UIView()
    }

    @objc private func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            munchkinTableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height + 20.0, 0)
        }
    }
    
    @objc private func keyboardWillHide(_ notification:Notification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            munchkinTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
}

extension MunchkinNamesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MunchkinsDatabase.shared.munchkins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Manchkin") as? MunchkinSetupTableViewCell {
            cell.munchkinNameDelegate = self
            cell.themePickerDelegate = self
            cell.applyPlayerNumber(with: indexPath.row)
            cell.munchkin = MunchkinsDatabase.shared.munchkins[indexPath.row]
            return cell
        } else {
            return UITableViewCell.init()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationViewController = segue.destination as? UINavigationController, let themePickerVC = navigationViewController.topViewController as? ThemePickerViewController {
            themePickerVC.munchkin = self.munchkin
        }
    }
    
}

extension MunchkinNamesViewController: ChangableWithMunchkinName {
    
    func cellDidRequestToApplyMunchkinName(cell: UITableViewCell) {
        let index = munchkinTableView.indexPath(for: cell)?.row
        MunchkinsDatabase.shared.chooseRandomNameForMunchkin(at: index)
    }
    
}

extension MunchkinNamesViewController: SelectableWithTheme {
    
    func cellDidRequestToOpenThemePicker(cell: UITableViewCell, munchkin: Munchkin) {
        self.munchkin = munchkin
        performSegue(withIdentifier: "ThemePickerSegue", sender: self)
    }
    
}
