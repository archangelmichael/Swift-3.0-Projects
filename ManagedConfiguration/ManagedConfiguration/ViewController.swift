//
//  ViewController.swift
//  ManagedConfiguration
//
//  Created by Radi on 7/4/17.
//  Copyright © 2017 Oryx. All rights reserved.
//

import UIKit

enum LoadingState {
    case idle, busy
}

class ViewController: UIViewController {
    // The Managed app configuration dictionary pushed down from an MDM server are stored in this key.
    static let kConfigurationKey = "com.apple.configuration.managed"
    
    // This sample application allows for a server url and cloud document switch to be configured via MDM
    // Application developers should document feedback dictionary keys, including data types and valid value ranges.
    static let kConfigurationServerURLKey = "serverURL"
    static let kConfigurationDisableCloudDocumentSyncKey = "disableCloudDocumentSync"
    
    // The dictionary that is sent back to the MDM server as feedback must be stored in this key.
    static let kFeedbackKey = "com.apple.feedback.managed"
    
    // This sample application tracks a success and failure count for the loading of a UIWebView.
    // Application developers should document feedback dictionary keys including data types to expect for feedback queries
    static let kFeedbackSuccessCountKey = "successCount"
    static let kFeedbackFailureCountKey = "failureCount"
    
    @IBOutlet weak var lblServerUrl: UILabel!
    @IBOutlet weak var lblSuccess: UILabel!
    @IBOutlet weak var lblFailure: UILabel!
    @IBOutlet weak var switchSyncEnabled: UISwitch!
    @IBOutlet weak var btnGo: UIButton!
    @IBOutlet weak var wvInfo: UIWebView!
    
    var successCount : Int = 0
    var failureCount : Int = 0
    var loadingState : LoadingState = .idle;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.wvInfo.delegate = self
        self.wvInfo.layer.borderColor = UIColor.lightGray.cgColor
        self.wvInfo.layer.borderWidth = 1.0;
        
        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification,
                                               object: nil,
                                               queue: OperationQueue.main) { (note) in
                                                self.readDefaultsValues();
        }
        
        
        self.readDefaultsValues()
    }
    
    @IBAction func onGo(_ sender: Any) {
        if (self.loadingState == .idle) {
            self.loadingState = .busy;
            self.btnGo.isEnabled = false;
            
            if let urlString = self.lblServerUrl.text {
                if let url = URL(string: urlString) {
                    let requestUrl = URLRequest(url: url)
                    self.wvInfo.loadRequest(requestUrl)
                }
            }
        }
    }
    
    func readDefaultsValues() -> Void {
        let defaults : UserDefaults = UserDefaults.standard
        
        if let serverConfig = defaults.dictionary(forKey: ViewController.kConfigurationKey) {
            if let serverUrl : String = serverConfig[ViewController.kConfigurationServerURLKey] as? String {
                self.lblServerUrl.text = serverUrl
            }
            else {
                self.lblServerUrl.text = "http://foo.bar"
            }
            
            if let disableDocSync = serverConfig[ViewController.kConfigurationDisableCloudDocumentSyncKey] as? Int {
                self.switchSyncEnabled.isOn = true
            }
            else {
                self.switchSyncEnabled.isOn = false
            }
        }
        else {
            self.lblServerUrl.text = "http://www.google.com"
            self.switchSyncEnabled.isOn = false
        }
        
        // Fetch the success and failure count values from NSUserDefaults to display.
        // Data validation for feedback values is a good idea, in case the application wrote out an unexpected value.
        if let feedback = defaults.dictionary(forKey: ViewController.kFeedbackKey) {
            if let success = feedback[ViewController.kFeedbackSuccessCountKey] as? Int {
                self.successCount = success
            }
            else {
                self.successCount = 0
            }
            
            self.lblSuccess.text = "\(self.successCount)"
            
            
            if let failure = feedback[ViewController.kFeedbackFailureCountKey] as? Int {
                self.failureCount = failure
            }
            else {
                self.failureCount = 0
            }
            
            self.lblFailure.text = "\(self.failureCount)"
        }
    }
    
    func incrementSuccessCount() {
        self.successCount += 1
        self.lblSuccess.text = "\(self.successCount)"
        
        var feedback : NSMutableDictionary? = UserDefaults.standard.dictionary(forKey: ViewController.kFeedbackKey) as? NSMutableDictionary
        if feedback == nil {
            feedback = NSMutableDictionary()
        }
        
        feedback![ViewController.kFeedbackSuccessCountKey] = self.successCount
        UserDefaults.standard.set(feedback!, forKey: ViewController.kFeedbackKey)
//        UserDefaults.standard.synchronize()
    }
    
    func incrementFailureCount() {
        self.failureCount += 1
        self.lblFailure.text = "\(self.failureCount)"
        
        var feedback : NSMutableDictionary? = UserDefaults.standard.dictionary(forKey: ViewController.kFeedbackKey) as? NSMutableDictionary
        if feedback == nil {
            feedback = NSMutableDictionary()
        }
        
        feedback![ViewController.kFeedbackFailureCountKey] = self.failureCount
        UserDefaults.standard.set(feedback!, forKey: ViewController.kFeedbackKey)
//        UserDefaults.standard.synchronize()
    }
}

extension ViewController : UITextViewDelegate {
    
}

extension ViewController : UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if self.loadingState == .busy {
            self.loadingState = .idle
            self.btnGo.isEnabled = true
            self.incrementSuccessCount();
        }
    }
    
    func webView(_ webView: UIWebView,
                 didFailLoadWithError error: Error) {
        if self.loadingState == .busy {
            self.loadingState = .idle;
            self.btnGo.isEnabled = true
            self.incrementFailureCount();
        }
    }
}

extension ViewController : UIGestureRecognizerDelegate {
    
}

