//
//  LeftSideMenuController.swift
//  Not Hotdog?
//
//  Created by Michael Einman on 5/10/21.
//

import Foundation
import UIKit

class LeftSideMenuController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkAssColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        
        
    }
    
    let darkAssColor = UIColor (red: 33/255.0,
                                green: 33/255.0,
                                blue: 33/255.0,
                                alpha: 0.5)
    
    var menuItems = [
        "picture.example1",
        "picture.example2",
        "picture.example3",
    ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row] //passing Items to side menu here.. modify for data persistence
        cell.textLabel?.textColor = .white
        cell.textLabel?.backgroundColor = darkAssColor
//        cell.textLabel?.text =
        return cell
    }
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        if let currentSelection = tableView.cellForRow(at: indexPath) {
//            if currentSelection.textLabel?.text == "weektoweek"{
//                do code
//            }
//        }
//    }
    //MARK: - Allow table cell editing
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in //action
//
//            let alert = UIAlertController(title: "", message: "Edit Photo Name", preferredStyle: .alert)
//            alert.addTextField { UITextField in
//                UITextField.text = self.menuItems[indexPath.row]
//            })
//            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
//                 self.list[indexPath.row] = alert.textFields!.first!.text!
//                 self.tableView.reloadRows(at: [indexPath], with: .fade)
//             }))
//             alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//             self.present(alert, animated: false)
//         })
//
//         let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
//             self.menuItems.remove(at: indexPath.row)
//             tableView.reloadData()
//         })
//
//         return [deleteAction, editAction]
//     }
//
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            let alert = UIAlertController(title: "", message: "Edit Photo Name", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textField) in
                textField.text = self.menuItems[indexPath.row]
            })
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
                self.menuItems[indexPath.row] = alert.textFields!.first!.text!
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: false)
        })

        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            self.menuItems.remove(at: indexPath.row)
            tableView.reloadData()
        })

        return [deleteAction, editAction]
    }
    
    
    
    
    
    
    
    
    
    
}
