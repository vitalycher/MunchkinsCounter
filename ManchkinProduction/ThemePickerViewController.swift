//
//  ThemePickerViewController.swift
//  ManchkinProduction
//
//  Created by Vitaly Chernish on 20.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import UIKit

class ThemePickerViewController: UIViewController {

    @IBOutlet weak private var themePickerTableView: UITableView!
    
    @IBAction func dismissThemePicker(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseTheme(_ sender: UIBarButtonItem) { }
    
}

extension ThemePickerViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ThemePickerCell") {
            return cell
        } else {
            return UITableViewCell.init()
        }
    }
    
}
