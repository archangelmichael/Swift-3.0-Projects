//
//  SettingsViewController.swift
//  What Next
//
//  Created by Radi on 2/13/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    
    @IBOutlet weak var btnSelectTheme: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnLogout.tintColor = Constants.Colors.ORANGE
        self.btnLogout.setImage(UIImage.init(named: "logout-on")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate),
                                for: .normal)
        self.btnLogout.setImage(UIImage.init(named: "logout-off")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate),
                                for: .selected)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBackgroundColor()
        
        self.setSelectedTheme()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return Variables.statusBarStyle
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSelectedTheme() -> Void {
        let theme = Variables.getTheme()
        switch theme {
        case Theme.black:
            self.btnSelectTheme.selectedSegmentIndex = 0
            break
        case Theme.dark:
            self.btnSelectTheme.selectedSegmentIndex = 1
            break
        default:
            self.btnSelectTheme.selectedSegmentIndex = 2
            break
        }
    }
    
    @IBAction func onThemeChange(_ sender: Any) {
        let selectedThemeIndex = self.btnSelectTheme.selectedSegmentIndex
        var selectedTheme = Theme.black
        switch selectedThemeIndex {
        case 0:
            selectedTheme = Theme.black
            break
        case 1:
            selectedTheme = Theme.dark
            break
        default:
            selectedTheme = Theme.white
            break
        }
        
        Variables.setTheme(theme: selectedTheme)
        self.setBackgroundColor()
        (self.tabBarController as? TabsViewController)?.setTabBarColor()
    }
    
    @IBAction func onLogout(_ sender: Any) {
        self.performLogout()
    }

    func performLogout() -> Void {
        UserDefaults.standard.set(false, forKey: Constants.Keys.AppSaveLogin)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
