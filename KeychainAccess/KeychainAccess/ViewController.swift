//
//  ViewController.swift
//  KeychainAccess
//
//  Created by Radi on 7/10/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var accessValue : String?
    {
        get {
            return tfInput.text
        }
    }
    
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
        log(text: "")
        do {
            try KeychainWrapper.saveKey(value: self.accessValue)
            log(text: "update complete")
        }
        catch let error {
            log(text: error.localizedDescription)
        }
    }
    
    @IBAction func onDelete(_ sender: Any) {
        log(text: "")
        do {
            try KeychainWrapper.deleteKey()
            log(text: "delete complete")
        }
        catch let error {
            log(text: error.localizedDescription)
        }
    }
    
    @IBAction func onFind(_ sender: Any) {
        log(text: "")
        do {
            let password = try KeychainWrapper.loadKey()
            log(text: "find complete \(password)")
        }
        catch let error {
            log(text: error.localizedDescription)
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

