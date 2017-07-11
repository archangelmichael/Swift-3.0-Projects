//
//  ViewController.swift
//  KeychainAccess
//
//  Created by Radi on 7/10/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class ViewController: UIViewController {

    var accessValue : String?
    {
        get {
            return tfInput.text
        }
    }
    
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var lblResult: UILabel!
    
    let keychainKey : String = "certificate-key"
    let keychainService: String = "UConnect"
    let keychainGroup : String = "P4JVA28GY3.com.oryx.shared.keychain"
    var keychainWrapper : KeychainWrapper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfInput.delegate = self
        keychainWrapper = KeychainWrapper(serviceName: keychainService,
                                          accessGroup: keychainGroup)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onAdd(_ sender: Any) {
        log(text: "")
        do {
            try MyKeychainWrapper.saveKey(value: self.accessValue! + "1")
            log(text: "update complete")
        }
        catch let error {
            log(text: error.localizedDescription)
        }
    }
    
    @IBAction func onFind(_ sender: Any) {
        log(text: "")
        do {
            let password = try MyKeychainWrapper.loadKey()
            log(text: "find complete \(password)")
        }
        catch let error {
            log(text: error.localizedDescription)
        }
    }
    
    @IBAction func onDelete(_ sender: Any) {
        log(text: "")
        do {
            try MyKeychainWrapper.deleteKey()
            log(text: "delete complete")
        }
        catch let error {
            log(text: error.localizedDescription)
        }
    }
    
    @IBAction func onSave(_ sender: Any) {
        let save = keychainWrapper!.set(accessValue! + "2",
                                       forKey: keychainKey,
                                       withAccessibility: KeychainItemAccessibility.whenUnlocked)
        if save {
            log(text: "save complete")
        }
        else {
            log(text: "save failed")
        }
    }
    
    @IBAction func onLoad(_ sender: Any) {
        if let load = keychainWrapper!.string(forKey: keychainKey,
                                             withAccessibility: KeychainItemAccessibility.whenUnlocked) {
            log(text: "load complete \(load)")
        }
        else {
            log(text: "load failed")
        }
    }

    @IBAction func onRemove(_ sender: Any) {
        let success = keychainWrapper!.removeObject(forKey: keychainKey,
        withAccessibility: KeychainItemAccessibility.whenUnlocked)
        log(text: "Remove Successful: \(success)")
    }
    
    func log(text: String) -> Void {
        self.lblResult.text = text
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

