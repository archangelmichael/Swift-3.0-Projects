//
//  ViewController.swift
//  KeychainAccess
//
//  Created by Radi on 7/10/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let itemKey = "certificate-key"
    var itemValue : String?
    {
        get {
            return tfInput.text
        }
    }
    
    let keychainAccessGroupName = "P4JVA28GY3.com.oryx.shared.keychain"
    
    @IBOutlet weak var tfInput: UITextField!
    
    @IBOutlet weak var lblResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfInput.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onAdd(_ sender: Any) {
        guard let valueData = itemValue?.data(using: String.Encoding.utf8) else {
            print("Error saving text to Keychain")
            return
        }
        
        let queryAdd: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: itemKey as AnyObject,
            kSecValueData as String: valueData as AnyObject,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked,
            kSecAttrAccessGroup as String: keychainAccessGroupName as AnyObject
        ]
        
        let resultCode = SecItemAdd(queryAdd as CFDictionary, nil)
        
        if resultCode != noErr {
            print("Error saving to Keychain: \(resultCode)")
            if resultCode == -25299 {
                log(text: "item already added")
                self.onUpdate()
            }
        }
        else {
            log(text: "item added")
        }
    }
    
    @IBAction func onDelete(_ sender: Any) {
        let queryDelete: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: itemKey as AnyObject,
            kSecAttrAccessGroup as String: keychainAccessGroupName as AnyObject
        ]
        
        let resultCodeDelete = SecItemDelete(queryDelete as CFDictionary)
        
        if resultCodeDelete != noErr {
            print("Error deleting from Keychain: \(resultCodeDelete)")
            if resultCodeDelete == -25300 {
                log(text: "item already deleted")
            }
        }
        else {
            log(text: "item deleted")
        }
    }
    
    @IBAction func onFind(_ sender: Any) {
        let queryLoad: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: itemKey as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecAttrAccessGroup as String: keychainAccessGroupName as AnyObject
        ]
        
        var result: AnyObject?
        
        let resultCodeLoad = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(queryLoad as CFDictionary, UnsafeMutablePointer($0))
        }
        
        if resultCodeLoad == noErr {
            if let result = result as? Data,
                let keyValue = NSString(data: result,
                                        encoding: String.Encoding.utf8.rawValue) as String? {
                
                log(text: keyValue)
            }
        }
        else {
            print("Error loading from Keychain: \(resultCodeLoad)")
            if resultCodeLoad == -25300 {
                log(text: "item not found")
            }
        }
    }
    
    func onUpdate() {
        guard let valueData = itemValue?.data(using: String.Encoding.utf8) else {
            print("Error saving text to Keychain")
            return
        }
        
        let queryUpdate: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: itemKey as AnyObject,
            kSecValueData as String: valueData as AnyObject,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecAttrAccessGroup as String: keychainAccessGroupName as AnyObject,
        ]
        
        let resultCode = SecItemUpdate(queryUpdate as CFDictionary,
                                       [kSecValueData as String : valueData] as CFDictionary)
        
        if resultCode != noErr {
            print("Error updating to Keychain: \(resultCode)")
            if resultCode == -25299 {
                log(text: "item not updated")
            }
        }
        else {
            log(text: "item updated")
        }
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

