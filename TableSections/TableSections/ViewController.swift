//
//  ViewController.swift
//  TableSections
//
//  Created by Radi on 7/20/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

enum UserRole {
    case Manager
    case User
}

class ViewController: UIViewController {
    
    @IBOutlet weak var switchAccount: UISwitch!
    
    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var tvMenu: UITableView!
    
    var menuItems : [MenuItem] {
        get {
            return [
                MenuItem(section: .Leave, title: "action 1", action: 1),
                MenuItem(section: .Leave, title: "action 2", action: 2),
                MenuItem(section: .Leave, title: "action 3", action: 3),
                MenuItem(section: .Approvals, title: "action 4", action: 4),
                MenuItem(section: .Approvals, title: "action 5", action: 5),
                MenuItem(section: .Approvals, title: "action 6", action: 6),
                MenuItem(section: .Toolkit, title: "action 7", action: 7),
                MenuItem(section: .Toolkit, title: "action 8", action: 8),
                MenuItem(section: .Toolkit, title: "action 9", action: 9),
                MenuItem(section: .Toolkit, title: "action 10", action: 10),
                MenuItem(section: .Toolkit, title: "action 11", action: 11)
            ]
        }
    }
    
    var tvSections : [MenuSection] = []
    var tvItems : [[MenuItem]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvMenu.dataSource = self
        tvMenu.delegate = self
        
        switchAccount.setOn(true, animated: false)
        setupFor(role: .Manager)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onAccountChange(_ sender: Any) {
        setupFor(role: switchAccount.isOn ? .Manager : .User)
    }
    
    func setupFor(role: UserRole) {
        getDataForRole(role: role)
        tvMenu.reloadData()
    }
    
    func getDataForRole(role: UserRole) {
        switch role {
        case .Manager:
            GetItemsForSections(secs: MenuSection.allValues)
            break;
        default:
            GetItemsForSections(secs: [.Leave, .Toolkit])
            break;
        }
    }
    
    func GetItemsForSections(secs: [MenuSection]) {
        var sections = [MenuSection]()
        var items : [[MenuItem]] = [[MenuItem]]()
        for sec in secs {
            if !sections.contains(sec) {
                sections.append(sec)
                var secItems : [MenuItem] = [MenuItem]()
                for menuItem in menuItems {
                    if menuItem.section == sec {
                        secItems.append(menuItem)
                    }
                }
                
                items.append(secItems)
            }
        }
        
        tvSections = sections
        tvItems = items
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tvSections[section].rawValue;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tvSections.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvItems[section].count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let rowTitle = tvItems[indexPath.section][indexPath.row].title
        cell.textLabel?.text = rowTitle
        return cell
    }
}

extension ViewController : UITableViewDelegate {

}

