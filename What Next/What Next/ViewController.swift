//
//  ViewController.swift
//  What Next
//
//  Created by Radi on 2/13/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    
    @IBOutlet weak var lblRemember: UILabel!
    @IBOutlet weak var swRemember: UISwitch!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var vLoading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Variables.getTheme()
        
        self.btnLogin.roundCorners()
        self.tfPass.delegate = self
        self.tfName.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setBackgroundColor()
        self.swRemember.isOn = UserDefaults.standard.bool(forKey: Constants.Keys.AppSaveLogin)
        
        self.tfName.text = "Angel"
        self.tfPass.text = "arch"
        
        self.vLoading.stopAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: Constants.Keys.AppSaveLogin) {
            self.performLogin()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return Variables.statusBarStyle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRemember(_ sender: Any) {
        let active = self.swRemember.isOn
        UserDefaults.standard.set(active, forKey: Constants.Keys.AppSaveLogin)
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let pass = self.tfPass.text
        if pass != "arch" {
            Alerts.showOkAlert(title: NSLocalizedString("msg_alert_bad_login", comment: ""),
                               message: NSLocalizedString("msg_alert_wrong_password", comment: ""),
                               handler: nil,
                               sender: self)
            self.vLoading.stopAnimating()
            return
        }
        
        self.performLogin()
    }
    
    func performLogin() -> Void {
        self.vLoading.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.vLoading.stopAnimating()
            self.performSegue(withIdentifier: "showTabs", sender: self)
        }
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.tfName {
            self.tfPass.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
            self.onLogin(self.btnLogin)
        }
        
        return true
    }
}

