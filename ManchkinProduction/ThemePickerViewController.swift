//
//  ThemePickerViewController.swift
//  ManchkinProduction
//
//  Created by Vitaly Chernish on 20.03.17.
//  Copyright © 2017 Vitaly Chenrish. All rights reserved.
//

import UIKit

class ThemePickerViewController: UIViewController {
    
    var munchkin: Munchkin?
    
    @IBOutlet weak private var themePickerTableView: UITableView!
    
    @IBAction func dismissThemePicker(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ThemePickerViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MunchkinThemes.shared.themes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ThemePickerCell") as? ThemeTableViewCell {
            cell.themeApplyDelegate = self
            let currentTheme = MunchkinThemes.shared.themes[indexPath.row]
            cell.theme = currentTheme
            return cell
        } else {
            return UITableViewCell.init()
        }
    }
    
}

extension ThemePickerViewController: AppliableWithTheme {
    
    func cellDidRequestToApplyTheme(cell: UITableViewCell, theme: Theme) {
        MunchkinThemes.shared.applyTheme(theme, forMunchkin: munchkin ?? Munchkin())
        dismiss(animated: true, completion: nil)
    }
    
}
