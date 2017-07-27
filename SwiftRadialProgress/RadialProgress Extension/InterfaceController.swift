//
//  InterfaceController.swift
//  RadialProgress Extension
//
//  Created by Radi on 7/27/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
    
    @IBOutlet var ivProgress: WKInterfaceImage!
    @IBOutlet var lblExpiration: WKInterfaceLabel!
    
    @IBOutlet var btnResetPass: WKInterfaceButton!
    
    let redirectUrl : String = "https://www.google.com"
    
    var wcsession : WCSession?
    
//    var session: WCSession? {
//        didSet {
//            if let session = session {
//                session.delegate = self
//                session.activate()
//            }
//        }
//    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if WCSession.isSupported() {
            self.wcsession = WCSession.default()
            self.wcsession?.delegate = self
            self.wcsession?.activate()
        }
        
//        self.btnResetPass.setHidden(true)
    }
    
    @IBAction func onResetPass() {
        if let session = wcsession {
            session.sendMessage(["url" : redirectUrl],
                                  replyHandler:
                {
                    (dict) -> Void in
                    print("InterfaceController session response: \(dict)")
            },
                                  errorHandler:
                {
                    (error) -> Void in
                    print("InterfaceController session error: \(error)")
            })
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.ReloadPassExpiration()
        
    }
    
    func ReloadPassExpiration() {
        // TODO: Get pass expiration days left
        let daysLeft = (Int)(arc4random() % 20)
        if daysLeft <= 0 {
            ivProgress.setHidden(true)
            lblExpiration.setText("Password has expired")
            lblExpiration.setTextColor(UIColor.red)
            // btnResetPass.setHidden(false)
        }
        else {
            ivProgress.setHidden(false)
            lblExpiration.setText(daysLeft == 1 ? "day left until password expires" : "days left until password expires")
            lblExpiration.setTextColor(UIColor.white)
            // btnResetPass.setHidden(true)
            ivProgress.setImageNamed("pass-expiration")
            ivProgress.startAnimatingWithImages(in: NSMakeRange(0, daysLeft + 1),
                                                duration: 2,
                                                repeatCount: 1)
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

extension InterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
    }
    
    @available(iOS 9.3, *)
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {
        print("WATCH ACTIVATION ERROR \(String(describing: error?.localizedDescription))")
    }
}
