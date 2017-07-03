//
//  ViewController.swift
//  TouchId
//
//  Created by Radi on 7/3/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTouchId(_ sender: UIButton) {
        let context : LAContext = LAContext()
        var capabilityError: NSError?
        let reasonString = "Authentication with touch id is needed to access the app."
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &capabilityError) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reasonString,
                                   reply:
                { (success, error) in
                    if success {
                        print("Authentication complete")
                    }
                    else {
                        if error != nil {
                            let code = (error! as NSError).code
                            switch code {
                            case LAError.systemCancel.rawValue:
                                print("Authentication was cancelled by the system")
                                break
                                
                            case LAError.userCancel.rawValue:
                                print("Authentication was cancelled by the user")
                                break
                                
                                
                            case LAError.touchIDLockout.rawValue:
                                print("Touch id lockout")
                                OperationQueue.main.addOperation({
                                    self.showPasswordAlert()
                                })
                                break
                                
                            case LAError.userFallback.rawValue:
                                OperationQueue.main.addOperation({
                                    self.showPasswordAlert()
                                })
                                break
                            default:
                                OperationQueue.main.addOperation({
                                    self.showPasswordAlert()
                                })
                            }
                        }
                        else {
                            print("\(String(describing: error))")
                        }
                        
                        
                    }
            })
        }
        else {
            switch capabilityError!.code{
                
            case LAError.touchIDNotEnrolled.rawValue:
                print("TouchID is not enrolled")
                
            case LAError.passcodeNotSet.rawValue:
                print("A passcode has not been set")
                
            default:
                // The LAError.TouchIDNotAvailable case.
                print("TouchID not available")
            }
            
            // Show the custom alert view to allow users to enter the password.
            self.showPasswordAlert()
        }
        
    }

    func showPasswordAlert() -> Void {
        let alertVC = UIAlertController(title: "Touch Id failed",
                                        message: "Please type your password",
                                        preferredStyle: .alert)
        
        alertVC.addTextField { (tfPass) in
            tfPass.placeholder = "password"
            tfPass.isSecureTextEntry = true
        }
        
        let actionOk = UIAlertAction(title: "OK",
                                     style: UIAlertActionStyle.default)
        { [weak alertVC] (action) in
            if let password = alertVC?.textFields?[0].text {
                print("Password \(password)")
            }
        }
        alertVC.addAction(actionOk)
        
        let actionCancel = UIAlertAction(title: "Cance",
                                         style: UIAlertActionStyle.cancel,
                                         handler: nil)
        alertVC.addAction(actionCancel)
        self.present(alertVC, animated: true, completion: nil)
    }
}

